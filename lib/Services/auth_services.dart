import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Services/db_services.dart';

class AuthServices {
  static signIn({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.code,
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
      ));
    } catch (e) {
      print("Something wen wrong");
    }
  }

  static signUp({
    required email,
    required password,
    required name,
  }) async {
    try {
      // Create User
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Update Display Name
        await user.updateDisplayName(name);
        await user.reload();

        // Store in Firestore
        await DbServices.createUser(
          userId: user.uid,
          email: user.email!,
          name: name,
        );}
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.code,
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
      ));
    } catch (e) {
      print("Something wen wrong");
    }
  }
}
