import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/auth/login/login_navigator.dart';
import 'package:todo_application/auth/login/login_screen_view_model.dart';
import 'package:todo_application/auth/register/register_screen.dart';
import 'package:todo_application/components/custom-text-form-field.dart';
import 'package:todo_application/home/home-screen.dart';
import '../../dialog_utils.dart';
class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginScreenViewModel viewModel = LoginScreenViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/images/main_background.png',
                  width: double.infinity, fit: BoxFit.fill),
              Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                      CustomTextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return ' please enter email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'please enter valid email';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          controller: viewModel.emailController,
                          keyBoardType: TextInputType.emailAddress),
                      CustomTextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return ' please enter password';
                            }
                            if (text.length < 6) {
                              return 'password should be at least 7 characters';
                            }
                            return null;
                          },
                          controller: viewModel.passwordController,
                          label: 'Password',
                          keyBoardType: TextInputType.number,
                          isPassword: true),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.login();
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account",
                              style: Theme.of(context).textTheme.titleSmall),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Text('SignUp'))
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void hideMyLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(context, 'Loading..');
  }

  @override
  void showMyMessage(String message) {
    DialogUtils.showMessage(context, message, positiveActionName: 'OK ',positiveAction: (){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }
}
