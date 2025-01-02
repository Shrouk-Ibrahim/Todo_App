import 'package:flutter/material.dart';
import 'package:todo_application/models/my_user.dart';

class AuthProvider extends ChangeNotifier{
  MyUser? currentUser ;

  void updateUser(MyUser newUser){
    currentUser =newUser ;
    notifyListeners() ;
  }
}