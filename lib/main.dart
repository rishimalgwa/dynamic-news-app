import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/firebase_options.dart';
import 'package:pingo_assignment_app/src/app.dart';
import 'package:pingo_assignment_app/src/common/di/di.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  getIt.registerSingleton<AppRouter>(AppRouter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
