import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Views/hollywood_movies_screen.dart';
import '../Views/bollywood_movies_screen.dart';
import '../Views/home_screen.dart';
import '../Views/watchLater_screen.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Colors.black54,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.34,
            child: DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCircleUser,
                      size: screenHeight * 0.14,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          'Guest User',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ??
                          'No email available',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawerItem(
              FontAwesomeIcons.house, "Home", () => Get.to(HomeScreen())),
          drawerItem(
              FontAwesomeIcons.video, "Hollywod", () => Get.to(Hollywood())),
          drawerItem(
              FontAwesomeIcons.video, "Bollywood", () => Get.to(Bollywood())),
          drawerItem(FontAwesomeIcons.list, "Watch Later",
              () => Get.to(WatchLater_Screen())),
          const Expanded(child: SizedBox()),
          drawerItem(FontAwesomeIcons.arrowRightFromBracket, "Sign Out",
              () async {
            await FirebaseAuth.instance.signOut();
          }),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, size: 24, color: Colors.yellow),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.yellow.shade200),
        ),
      ),
    );
  }
}
