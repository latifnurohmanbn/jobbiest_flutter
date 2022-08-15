import 'package:flutter/material.dart';
import 'package:jobbiest_flutter/models/user_model.dart';
import 'package:jobbiest_flutter/pages/home_page.dart';
import 'package:jobbiest_flutter/pages/signin_page.dart';
import 'package:jobbiest_flutter/providers/auth_provider.dart';
import 'package:jobbiest_flutter/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SignUpPages extends StatefulWidget {
  @override
  State<SignUpPages> createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController goalController = TextEditingController(text: '');

  bool isLoading = false;

  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: Duration(seconds: 2),
      ));
    }

    Widget uploadedImage() {
      return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              isUploaded = !isUploaded;
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/upload_pic.png',
                width: 100,
              )
            ],
          ),
        ),
      );
    }

    Widget showedImage() {
      return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              isUploaded = !isUploaded;
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/pic.png',
                width: 100,
              )
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: titleTextStyle,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Begin New Journey',
                    style: subTitleTextStyle,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        'assets/Ellipse.png',
                        height: 120,
                      ),
                      isUploaded ? showedImage() : uploadedImage(),
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: nameController,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Color(0xffF1F0F5),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Color(0xffF1F0F5),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xffF1F0F5),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none),
                          hintText: '',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Goal',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: goalController,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Color(0xffF1F0F5),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45,
                    width: MediaQuery.of(context).size.width - (2 * 24),
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              if (nameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  goalController.text.isEmpty) {
                                showError('All fields must be filled');
                              } else {
                                setState(() {
                                  isLoading = true;
                                });

                                UserModel? user = await authProvider.register(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    goalController.text);

                                setState(() {
                                  isLoading = false;
                                });

                                if (user == null) {
                                  showError('Email has been registered');
                                } else {
                                  userProvider.user = user;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePages()),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff4141A4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(66),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: buttonTextStyle,
                            )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPages()),
                        );
                      },
                      child: Text(
                        'Back to Sign In',
                        style: titleTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
