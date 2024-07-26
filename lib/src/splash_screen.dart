import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/common/widgets/loading_widget.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ThemeHelper t = ThemeHelper();
  bool isLogedIn = false;
  @override
  void initState() {
    super.initState();
    getAuthToken();
    Timer(const Duration(seconds: 1), () {
      // if (isLogedIn) {
      //   context.router.pushAndPopUntil(const DashboardRoute(),
      //       predicate: (route) => false);
      // }
      // if (!isLogedIn) {
      context.router
          .pushAndPopUntil(const SignupRoute(), predicate: (route) => false);
      // }
    });
  }

  getAuthToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // isLogedIn = pref.getString(accessTokenKey) != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(),
            SizedBox(height: 16),
            LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
