import 'package:auto_route/auto_route.dart';
import 'package:pingo_assignment_app/src/features/auth/presentation/pages/signin_screen.dart';
import 'package:pingo_assignment_app/src/features/auth/presentation/pages/signup_screen.dart';
import 'package:pingo_assignment_app/src/features/home/presentation/pages/home_screen.dart';
import 'package:pingo_assignment_app/src/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SigninRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
