import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/components/button.dart';
import 'package:google_signin/components/my_textField.dart';
import 'package:google_signin/components/square_tile.dart';
import 'package:google_signin/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final cnfrmPassController= TextEditingController();
  final passwordController = TextEditingController();

  //sign in method
  void signUserUp() async {
    //show circular progressbar
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    //try singn in user inbuilt method of firebase
    try {
      if(passwordController.text==cnfrmPassController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usernameController.text.trim(),
            password: passwordController.text.trim());

        Navigator.pop(context);
      }else{
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return const AlertDialog(
            title: Text("Password doesn't match"),
          );
        });
      }
      //pop out the circular bar after user is login
     // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPassword();
      }
    }
  }

  //wrong email
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Entered Wrong Email'),
          );
        });
  }

  //wrong password
  void wrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Entered Wrong Password'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                SizedBox(
                  height: 10,
                ),

                Icon(
                  Icons.lock,
                  size: 100,
                ),

                SizedBox(
                  height: 20,
                ),
                //welcome to the App
                Text(
                  "Let's create a account for you !",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),

                SizedBox(
                  height: 20,
                ),
                //username textfield
                MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false),

                SizedBox(
                  height: 20,
                ),

                //password textfield
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),

                SizedBox(
                  height: 20,
                ),

                //password textfield
                MyTextField(
                    controller: cnfrmPassController,
                    hintText: 'Confirm Password',
                    obscureText: true),


                SizedBox(
                  height: 20,
                ),
                //sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 30,
                ),

                //or continue with text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Or Continue With",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      ))
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                //google sign
                //apple sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(onTap: () => AuthService().signInWithGoogle(),imagePath: 'assets/images/google.png'),
                    SizedBox(
                      width: 30,
                    ),
                    SquareTile(onTap: (){},imagePath: 'assets/images/apple.png')
                  ],
                ),

                //option to register now text
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?'),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'login Now.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
