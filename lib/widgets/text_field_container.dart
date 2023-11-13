import 'package:favorite_places_app/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final String hintText;
  final bool isForDescription;
  final TextEditingController textEditingController;

  const TextFieldContainer(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      required this.isForDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(12)),
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 15, top: 7, bottom: 7),
        child: TextField(
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.multiline,
          maxLines: isForDescription ? 10 : 1,
          cursorColor: Colors.black,
          controller: textEditingController,
          decoration: InputDecoration(
              fillColor: Colors.black,
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
