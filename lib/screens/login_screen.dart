import 'package:favorite_places_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/helpers/auth_validator_helper.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';

import 'package:favorite_places_app/screens/home_screen.dart';
import 'package:favorite_places_app/widgets/overlay_loader.dart';
import 'package:favorite_places_app/widgets/rounded_button.dart';
import 'package:favorite_places_app/widgets/rounded_login_text_field.dart';
import 'package:favorite_places_app/widgets/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          OverlayLoader.hide(context);

          pushAndRemoveUntil(const HomeScreen(), '/HomeScreen');
        }
        if (state is AuthFailure) {
          showToast(state.errorMessage);
          OverlayLoader.hide(context);
        }
        if (state is AuthInProgress) {
          OverlayLoader.show(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "LOGIN",
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("assets/images/signup.svg"),
                const SizedBox(
                  height: 80,
                ),
                RoundedLoginTextField(
                  hintText: "Email",
                  textEditingController: _emailController,
                  isNameTextField: false,
                  isPasswordTextFiend: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedLoginTextField(
                  hintText: "Password",
                  textEditingController: _passwordController,
                  isNameTextField: false,
                  isPasswordTextFiend: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  buttonColor: kPrimaryColor,
                  textColor: Colors.white,
                  title: "LOGIN",
                  onTapFunction: () async {
                    if (AuthVlidatorHelper().validateUserInput(
                        _emailController.text, _passwordController.text)) {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthLoggedInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
