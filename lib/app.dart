import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6
          ),
        )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              padding: const EdgeInsets.symmetric(vertical: 11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6
            ),
          )
      ),

      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
