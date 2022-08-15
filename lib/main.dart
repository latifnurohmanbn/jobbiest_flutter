import 'package:flutter/material.dart';
import 'package:jobbiest_flutter/pages/home_page.dart';
import 'package:jobbiest_flutter/pages/signin_page.dart';
import 'package:jobbiest_flutter/pages/signup_page.dart';
import 'package:jobbiest_flutter/pages/splash_page.dart';
import 'package:jobbiest_flutter/pages/started_page.dart';
import 'package:jobbiest_flutter/providers/auth_provider.dart';
import 'package:jobbiest_flutter/providers/category_provider.dart';
import 'package:jobbiest_flutter/providers/job_provider.dart';
import 'package:jobbiest_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()),
        ChangeNotifierProvider<JobProvider>(create: (context) => JobProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/started': (context) => GetStartedPage(),
          '/sign-in': (context) => SignInPages(),
          '/sign-up': (context) => SignUpPages(),
          '/home': (context) => HomePages(),
        },
      ),
    );
  }
}
