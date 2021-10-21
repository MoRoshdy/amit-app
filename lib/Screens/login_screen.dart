import 'package:amit_app/Screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bottomNavigatinBar_items.dart';


class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void initState() {
    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool abscure = true;
  @override
  void dispose() {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(50),
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/amit.jpg'),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: 'Email',
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter your Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: abscure,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Password',
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  abscure = !abscure;
                                  setState(() {});
                                },
                                icon: Icon(abscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter your password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * .5,
                    height: size.height * .05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (formkey.currentState.validate()) {
                          var result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailcontroller.text,
                                  password: _passwordcontroller.text);

                          if (result.user != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => bottomNavigationBar()),
                            );
                          } else {
                            print('user not found');
                          }
                        }
                      },
                    ),
                  ),
                  // SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Go SignUp',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
