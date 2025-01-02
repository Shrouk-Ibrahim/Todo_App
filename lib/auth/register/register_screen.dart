import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/auth/login/login_screen.dart';
import 'package:todo_application/auth/register/register_navigator.dart';
import 'package:todo_application/auth/register/register_screen_view_model.dart';
import 'package:todo_application/components/custom-text-form-field.dart';
import 'package:todo_application/dialog_utils.dart';
import 'package:todo_application/home/home-screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var userNameController = TextEditingController(text: 'sheta');

  var emailController = TextEditingController(text: 'sheta@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var confirmationPasswordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();
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
      child: Scaffold (
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/images/main_background.png',
                  width: double.infinity, fit: BoxFit.fill),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                      CustomTextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return ' please enter username';
                            }
                            return null;
                          },
                          label: 'User Name ',
                          controller: userNameController),
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
                          controller: emailController,
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
                          controller: passwordController,
                          label: 'Password',
                          keyBoardType: TextInputType.number,
                          isPassword: true),
                      CustomTextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return ' please enter confirmation password';
                            }
                            if (text != passwordController.text) {
                              return "confirmation password doesn't match";
                            }
                            return null;
                          },
                          controller: confirmationPasswordController,
                          label: 'Confirmation Password',
                          keyBoardType: TextInputType.number,
                          isPassword: true),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            addRegister();
                          },
                          child: Text('Register',
                              style: Theme.of(context).textTheme.titleLarge),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          child: Text('Already has an account'))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void addRegister() async {
    if (formKey.currentState!.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(context, 'Loading ...');
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context,
      message,
      positiveActionName: 'ok',
      positiveAction: (){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    );
  }
}
