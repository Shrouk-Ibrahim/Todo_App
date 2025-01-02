import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/auth/login/login_navigator.dart';

class LoginScreenViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  late LoginNavigator navigator;
  void login() async {
    if (formKey.currentState!.validate() == true) {
      //register
      navigator.showMyLoading();
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // var user =await FireBaseUtils.readUserFromFireStore(credential.user?.uid?? '');
        // if(user == null){
        //   return ;
        // }
        // var authProvider = Provider.of<AuthProvider>(context,listen: false);
        // authProvider.updateUser(user);
        navigator.hideMyLoading();
        navigator.showMyMessage('Login successfully',
        );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          navigator.hideMyLoading();
          navigator.showMyMessage('Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage(e.toString());
      }
    }
  }
}
