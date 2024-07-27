import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/features/auth/data/user_model.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  late FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth
      .authStateChanges()
      .map(_userFromFirebase as UserModel Function(User? event));

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given User
  Future<UserModel> _userFromFirebase(User? user, String? name) async {
    if (user == null) {
      return UserModel(displayName: 'Null', uid: 'null', email: 'null');
    }
    var userModel = UserModel(
      uid: user.uid,
      email: user.email ?? "",
      displayName: name ?? user.displayName ?? "",
    );
    await saveUserData(userModel);
    return userModel;
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser, "");
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return await _userFromFirebase(result.user, name);
    } catch (e) {
      log("Error on the new user registration = $e");
      _status = Status.Unauthenticated;
      notifyListeners();
      return UserModel(displayName: 'Null', uid: 'null', email: 'null');
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      log("Error on the sign in = $e");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> saveUserData(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid.toString())
          .set({
        "displayName": user.displayName,
        "email": user.email,
        "uid": user.uid
      });
      return true;
    } catch (err, st) {
      log('Failed to save user data: $err');
      return false;
    }
  }
}
