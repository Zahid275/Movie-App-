import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/auth_fiield.dart';
import '../controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
final  AuthController authController = Get.put(AuthController());
final formKey = GlobalKey<FormState>();
AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
          child: Container(
            height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),

              child: Obx((){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.04),

                    Center(
                      child: SizedBox(
                          height: size.height*0.37,
                          child: Image.asset("assets/logo.png",fit: BoxFit.fill,)),
                    ),
                    Text(
                      authController.isSignUp.value ? "Sign Up" : "Sign In",
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         authController.isSignUp.value ?  AuthField(
                              onSaved: (value) {
                                authController.name = value;
                              },
                              validator: (value) =>
                                  value!.isEmpty ? "Please enter full name" : null,
                              label: "Full Name",
                            ):const SizedBox(),
                          AuthField(
                            onSaved: (value) {
                              authController.email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) return "Please Enter Email";
                              if (!value.contains("@")) return "Invalid Email";
                              return null;
                            },
                            label: "Email",
                          ),
                          AuthField(
                            onSaved: (value) {
                              authController.password = value;
                            },
                            validator: (value) => value!.length < 6
                                ? "Password must be at least 6 characters"
                                : null,
                            label: "Password",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  authController.isSignUp.value =
                                      !authController.isSignUp.value;
                                },
                                child: Text(
                                  authController.isSignUp.value
                                      ? "Already a member? Sign in"
                                      : "New here? Register",
                                  style:
                                      TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forget Password",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: size.height * 0.061,
                          width: size.width * 0.3,
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side:  BorderSide(
                                    color: Theme.of(context).primaryColor,width: 1.2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            onPressed: () {
                              print(authController.isSignUp.value);
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                authController.isSignUp.value
                                    ? authController.signUp(
                                        name: authController.name.toString(),
                                        email:
                                            authController.email.toString().trim(),
                                        password: authController.password
                                            .toString()
                                            .trim())
                                    : authController.signIn(
                                        email:
                                            authController.email.toString().trim(),
                                        password: authController.password
                                            .toString()
                                            .trim());
                              }
                            },
                            child: Text(
                              authController.isSignUp.value ? "Sign Up" : "Sign In",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColor, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (authController.isLoading.value)
                       Center(
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                      ),
                    SizedBox(height: size.height * 0.05),
                  ],
                );
              })
            ),

    ));

  }
}
