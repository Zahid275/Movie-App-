 import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'Views/home_screen.dart';

void main()async {
  await dotenv.load(fileName: ".env");

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,

        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.yellow,
            selectionColor: Colors.yellow[100],
            selectionHandleColor: Colors.yellow
        ),
        iconTheme: const IconThemeData(
          color: Colors.yellow
        ),
        indicatorColor: Colors.yellow,
        iconButtonTheme: const IconButtonThemeData(
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.yellow)
        ),




      ),
      debugShowCheckedModeBanner: false,
      home:HomeScreen()
    );
  }
}
