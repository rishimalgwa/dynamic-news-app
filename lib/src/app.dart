import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingo_assignment_app/src/common/di/di.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/core/providers/auth_provider.dart';
import 'package:pingo_assignment_app/src/features/home/data/repository/news_repo.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:pingo_assignment_app/src/services/firebase_remote_config_service.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoggedIn = false;

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        Provider<NewsRepo>(
          create: (context) => NewsRepo(),
        ),
        Provider<NewsRepo>(
          create: (context) => NewsRepo(),
        ),
        Provider<FirebaseRemoteConfigService>(
          create: (_) => FirebaseRemoteConfigService()..initialize(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(
          deepLinkBuilder: (deeplink) {
            return const DeepLink([SplashRoute()]);
          },
        ),
        title: 'Bowandarrow Employee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: ThemeHelper.bgColor,
            appBarTheme: AppBarTheme(
              backgroundColor: ThemeHelper.bgColor,
            ),
            cardTheme: CardTheme(
              color: ThemeHelper.white,
            )),
      ),
    );
  }
}
