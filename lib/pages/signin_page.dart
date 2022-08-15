import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobbiest_flutter/models/user_model.dart';
import 'package:jobbiest_flutter/pages/home_page.dart';
import 'package:jobbiest_flutter/pages/signup_page.dart';
import 'package:jobbiest_flutter/providers/auth_provider.dart';
import 'package:jobbiest_flutter/providers/user_provider.dart';
import 'package:jobbiest_flutter/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class SignInPages extends StatefulWidget {
  @override
  State<SignInPages> createState() => _SignInPagesState();
}

class _SignInPagesState extends State<SignInPages> {
  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

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

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 24,
              right: 24,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Sign In',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Build Your Career',
                style: subTitleTextStyle,
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/illustration_one.png',
                      height: 240,
                      width: 262,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
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
                    onChanged: (value) {
                      print(value);
                      bool isValid = EmailValidator.validate(value);
                      print(isValid);
                      if (isValid) {
                        setState(() {
                          isEmailValid = true;
                        });
                      } else {
                        setState(() {
                          isEmailValid = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F0F5),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              color: isEmailValid
                                  ? Color(0xff4141A4)
                                  : Color(0xffFD4F56))),
                      hintText: 'Enter your email address',
                    ),
                    style: TextStyle(
                      color:
                          isEmailValid ? Color(0xff4141A4) : Color(0xffFD4F56),
                    ),
                  ),
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
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF1F0F5),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Color(0xff4141A4)),
                        ),
                        hintText: 'Enter your password',
                      )),
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
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showError('Please complete all fields');
                          } else {
                            setState(() {
                              isLoading = true;
                            });

                            UserModel? user = await authProvider.login(
                              emailController.text,
                              passwordController.text,
                            );

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
                          'Sign In',
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
                      MaterialPageRoute(builder: (context) => SignUpPages()),
                    );
                  },
                  child: Text(
                    'Create New Account',
                    style: titleTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
