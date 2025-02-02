import 'package:flutter/material.dart';
import 'package:test_1/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("User Login")), body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User user;

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage(user)))
        });
  }

  Widget googleLoginButton() {
    return OutlinedButton(
      onPressed: this.click,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(vertical: 14),
        ),
        backgroundColor:
            WidgetStateProperty.all(Theme.of(context).primaryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/google_logo.png'),
                height: 35,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(color: Colors.blueGrey),
                  ))
            ]),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context)
  // {
  //   return Align(alignment: Alignment.center,
  //                 child:
  //           Padding(padding: EdgeInsets.all(10.0),
  //                   child:
  //           TextField(controller: textController,
  //                     decoration:
  //           InputDecoration(prefixIcon: Icon(Icons.person),
  //                           labelText: "Input Your Name",
  //                           suffixIcon:
  //                           IconButton(onPressed: click ,
  //                                       icon: Icon(Icons.send),
  //                                       splashColor: Colors.blue,
  //                                       tooltip: "Register Name",),
  //                           border: OutlineInputBorder(borderSide: BorderSide(width: 20, color: Colors.black))))));
  // }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}
