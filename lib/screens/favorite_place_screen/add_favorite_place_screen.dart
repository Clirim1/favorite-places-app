import 'dart:io';
import 'package:favorite_places_app/bloc/favorite_places_block/favorite_places_bloc.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/widgets/image_widget.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/widgets/pick_location_widget.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/widgets/title_widget.dart';
import 'package:favorite_places_app/widgets/add_favorite_place_button.dart';
import 'package:favorite_places_app/widgets/text_field_container.dart';
import 'package:favorite_places_app/widgets/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddFavoritePlaceScreen extends StatefulWidget {
  final FavoritePlaceModel? favoritePlaceModel;
  const AddFavoritePlaceScreen({super.key, this.favoritePlaceModel});

  @override
  State<AddFavoritePlaceScreen> createState() => _AddFavoritePlaceScreenState();
}

class _AddFavoritePlaceScreenState extends State<AddFavoritePlaceScreen> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  LatLng? locationPoint;

  @override
  void initState() {
    checkIsForEditable();
    super.initState();
  }

  checkIsForEditable() {
    if (widget.favoritePlaceModel != null) {
      setState(() {
        _placeNameController.text = widget.favoritePlaceModel!.title!;
        _descriptionController.text = widget.favoritePlaceModel!.description!;
        _image = widget.favoritePlaceModel!.imageFile!;
        locationPoint = LatLng(widget.favoritePlaceModel!.latitude!,
            widget.favoritePlaceModel!.longitude!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritePlacesBloc, FavoritePlaceState>(
      listener: (context, state) {
        if (state is FavoritePlaceAdded) {
          popNav();
        }
        if (state is FavoritePlaceUpdated) {
          popNav();
          popNav();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                headWidget(),
                ImageWidget(
                  image: _image,
                  pickImageFromCammera: _pickImageFromCamera,
                  pickImageFromGalery: _pickImageFromGallery,
                  deleteSelectedImage: deleteSelectedImage,
                ),
                const TitleWidget(title: "Name of place"),
                TextFieldContainer(
                  hintText: "Name of place",
                  textEditingController: _placeNameController,
                  isForDescription: false,
                ),
                const TitleWidget(title: "Description"),
                TextFieldContainer(
                  hintText: "Description",
                  textEditingController: _descriptionController,
                  isForDescription: true,
                ),
                PickLocationWidget(
                  createMakerFunction: updatePoint,
                  point: locationPoint,
                ),
                const SizedBox(
                  height: 30,
                ),
                AddFavoritePlaceButton(
                  title: widget.favoritePlaceModel != null
                      ? "Edit place"
                      : 'Add Place',
                  onTapFunction: widget.favoritePlaceModel == null
                      ? () {
                          if (validateFields()) {
                            FavoritePlaceModel favoritePlace =
                                FavoritePlaceModel(
                                    title: _placeNameController.text,
                                    description: _descriptionController.text,
                                    latitude: locationPoint!.latitude,
                                    longitude: locationPoint!.longitude,
                                    imageFile: _image);

                            context
                                .read<FavoritePlacesBloc>()
                                .add(AddFavoritePlace(favoritePlace));
                          }
                        }
                      : () {
                          if (validateFields()) {
                            FavoritePlaceModel newFavoritePlace =
                                FavoritePlaceModel(
                                    title: _placeNameController.text,
                                    description: _descriptionController.text,
                                    latitude: locationPoint!.latitude,
                                    longitude: locationPoint!.longitude,
                                    imageFile: _image);

                            context.read<FavoritePlacesBloc>().add(
                                UpdateFavoritePlace(widget.favoritePlaceModel!,
                                    newFavoritePlace));
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

  Widget headWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: popNav,
            child: Icon(Icons.arrow_back_ios),
          ),
          Text(
            "Add favorite place",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 20,
            height: 20,
          )
        ],
      ),
    );
  }

  updatePoint(LatLng point) {
    setState(() {
      locationPoint = point;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  deleteSelectedImage() {
    setState(() {
      _image = null;
    });
  }

  validateFields() {
    if (_image == null) {
      showToast("Image is required! Please add an image.");
      return false;
    }
    if (locationPoint == null) {
      showToast("Location is required! Please Add a location.");
      return false;
    }
    if (_placeNameController.text.isEmpty) {
      showToast("Please add a place of name First!");
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      showToast("Please add Description!");
      return false;
    }
    return true;
  }
}
