import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/auth/register/register_navigator.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    //register
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: userNameController.text,
      //     email: emailController.text);
      // var authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.updateUser(myUser);
      // await FireBaseUtils.addUserToFireStore(myUser);
      navigator.hideLoading();

      navigator.showMessage('Register Sucessfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();

        navigator.showMessage('The Password Provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();

        navigator.showMessage('The account already exists for that email');
      }
    } catch (e) {
      navigator.hideLoading();

      navigator.showMessage(e.toString());
    }
  }
}
