import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasaktii/core/models/task_model.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/theme.dart';
import 'package:tasaktii/feature/intro/splash.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox("userBox");
  await Hive.openBox("taskbox");
  AppLocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppLocalStorage.userbox.listenable(),
      builder: (context, userbox, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode:
                userbox.get(AppLocalStorage.kisdarkmode, defaultValue: false)
                    ? ThemeMode.dark
                    : ThemeMode.light,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            home: const Splash());
      },
    );
  }
}
