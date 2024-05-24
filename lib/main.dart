import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/config/theme/light_theme.dart';
import 'package:fitness_app/features/original/di/injection_container.dart';
import 'package:fitness_app/features/original/presentation/pages/nav/app_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: AppPage(),
    );
  }
}

