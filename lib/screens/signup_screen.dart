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
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInProgress) {
          OverlayLoader.show(context);
        }
        if (state is AuthSuccess) {
          OverlayLoader.hide(context);

          pushAndRemoveUntil(const HomeScreen(), '/HomeScreen');
        }
        if (state is AuthFailure) {
          OverlayLoader.hide(context);
          showToast(state.errorMessage);
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
                  "SIGNUP",
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
                    title: "SIGNUP",
                    onTapFunction: () async {
                      if (AuthVlidatorHelper().validateUserInput(
                          _emailController.text, _passwordController.text)) {
                        BlocProvider.of<AuthBloc>(context).add(AuthSignedUp(
                            _emailController.text, _passwordController.text));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
