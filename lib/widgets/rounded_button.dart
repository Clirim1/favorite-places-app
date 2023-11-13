import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color textColor;
  final Function() onTapFunction;
  const RoundedButton(
      {super.key,
      required this.buttonColor,
      required this.textColor,
      required this.title,
      required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
