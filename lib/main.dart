import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pingo_assignment_app/firebase_options.dart';
import 'package:pingo_assignment_app/src/app.dart';
import 'package:pingo_assignment_app/src/common/di/di.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:pingo_assignment_app/src/services/firebase_remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  configureDependencies();
  getIt.registerSingleton<AppRouter>(AppRouter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService().initialize();
  runApp(const App());
}
