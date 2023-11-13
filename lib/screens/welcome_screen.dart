import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/login_screen.dart';
import 'package:favorite_places_app/screens/signup_screen.dart';
import 'package:favorite_places_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset("assets/images/chat.svg"),
              const SizedBox(
                height: 80,
              ),
              RoundedButton(
                buttonColor: const Color(0XFF733FA7),
                textColor: Colors.white,
                title: "LOGIN",
                onTapFunction: () {
                  pushNav(const LoginScreen());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedButton(
                buttonColor: const Color(0XFFE6DBF2),
                textColor: Colors.black,
                title: "SIGNUP",
                onTapFunction: () {
                  pushNav(const SignUpScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
