import 'package:favorite_places_app/constants.dart';
import 'package:flutter/material.dart';

class RoundedLoginTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPasswordTextFiend;
  final bool isNameTextField;
  const RoundedLoginTextField(
      {super.key,
      required this.hintText,
      required this.isNameTextField,
      required this.isPasswordTextFiend,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(30)),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
        child: TextField(
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          controller: textEditingController,
          obscureText: isPasswordTextFiend,
          decoration: InputDecoration(
              fillColor: Colors.black,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 2, right: 10),
                child: Container(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  width: 11,
                  height: 11,
                  child: !isNameTextField
                      ? isPasswordTextFiend
                          ? const Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            )
                          : const Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            )
                      : const Icon(Icons.person),
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0XFF6C7275)),
              labelStyle: const TextStyle(color: Colors.black),
              border: InputBorder.none),
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
