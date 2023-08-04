import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/pages/home_page.dart';
import 'package:google_signin/pages/login_or_register.dart';
import 'package:google_signin/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(),
        builder:(context,snapshot){
          //if user is log in
          if(snapshot.hasData){
            return HomePage();
          }

          //if user is not logged in
          else{
            return LoginOrRegisterPage();
    }
        }
        //checking if user is already logged in or not
      ),
    );
  }
}
