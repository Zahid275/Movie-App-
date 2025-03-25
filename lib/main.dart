import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:z_flix/Views/auth_screen.dart';
import 'package:z_flix/controllers/home_controller.dart';
import 'Views/home_screen.dart';



void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await Future.delayed(const Duration(milliseconds: 500));

  FlutterNativeSplash.remove();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return customGetMaterialApp(home: HomeScreen());
          } else {
            return customGetMaterialApp(home: AuthScreen());
          }
        });
  }
}

Widget customGetMaterialApp({required Widget home}) {
  return GetMaterialApp(
    initialBinding: HomeBinding(),
      theme: ThemeData(
        primaryColor: Colors.yellow.shade300,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.yellow,
            selectionColor: Colors.yellow[100],
            selectionHandleColor: Colors.yellow),
        iconTheme:  IconThemeData(color: Colors.yellow.shade200),
        indicatorColor:  Colors.yellow.shade200,
        iconButtonTheme: const IconButtonThemeData(),

        appBarTheme:
             AppBarTheme(iconTheme: IconThemeData(color:  Colors.yellow.shade200)),
      ),
      debugShowCheckedModeBanner: false,
      home: home);
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}