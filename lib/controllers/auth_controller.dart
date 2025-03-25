import 'package:get/get.dart';
import 'package:z_flix/Services/auth_services.dart';

class AuthController extends GetxController {
  String? name;
  String? email;
  String? password;
  String? confirmPass;
  Rx<bool> isSignUp = false.obs;
  Rx<bool> isLoading = false.obs;



  signIn({required email, required password}) async {
    isLoading(true);
    await AuthServices.signIn(email: email, password: password);
    isLoading(false);
  }

  signUp({required email, required password, required name}) async {
    isLoading(true);
    await AuthServices.signUp(email: email, password: password, name: name);
    isLoading(false);
  }



}



