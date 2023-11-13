import 'package:favorite_places_app/constants.dart';
import 'package:flutter/material.dart';

class AddFavoritePlaceButton extends StatelessWidget {
  final String title;
  final Function() onTapFunction;
  const AddFavoritePlaceButton(
      {super.key, required this.title, required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
