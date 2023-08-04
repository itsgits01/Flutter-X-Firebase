import 'package:flutter/material.dart';
import 'package:google_signin/pages/register_page.dart';

import 'login_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //intialyy show loginpage
  bool showLoginPage= true;

  //toggle between login or register page

  void toggle(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override


  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap: toggle,
      );
    }else{
      return RegisterPage(
        onTap:toggle,
      );
    }
  }
}
