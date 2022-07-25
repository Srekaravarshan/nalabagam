import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nalabagam/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/recipe.jpg'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [
                          0.3,
                          1.0
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Login',style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || value != 'mavencart@mail.com') {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        hintText: 'Email',
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || value!= 'mavencart') {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(

                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                        hintText: 'Password',
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 58,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: TextStyle(
                                fontFamily: 'Montserrat')),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setBool('login', true);
                            prefs.setString('email', emailController.text);
                            prefs.setString(
                                'password', passwordController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        BuildContext ctx) => const Home()));
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Enter valid email and password',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
