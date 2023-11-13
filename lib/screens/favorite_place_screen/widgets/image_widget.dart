import 'dart:io';

import 'package:favorite_places_app/constants.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final File? image;
  final Function() pickImageFromGalery;
  final Function() pickImageFromCammera;
  final Function() deleteSelectedImage;
  const ImageWidget(
      {super.key,
      required this.image,
      required this.pickImageFromCammera,
      required this.pickImageFromGalery,
      required this.deleteSelectedImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(15),
        image: image != null
            ? DecorationImage(
                image: FileImage(
                  image!,
                ),
                fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: pickImageFromGalery,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                          size: 17,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Pick image",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      "|",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: pickImageFromCammera,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera_enhance,
                          size: 17,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Take Photo",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : InkWell(
              onTap: deleteSelectedImage,
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.topRight,
                height: 60,
                width: double.infinity,
                child: const Icon(
                  Icons.cancel,
                  size: 26,
                ),
              ),
            ),
    );
  }
}
