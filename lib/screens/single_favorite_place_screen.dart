import 'package:favorite_places_app/bloc/favorite_places_block/favorite_places_bloc.dart';
import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/add_favorite_place_screen.dart';
import 'package:favorite_places_app/widgets/add_favorite_place_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SingleFavoritePlaceScreen extends StatefulWidget {
  final FavoritePlaceModel favoritePlace;
  const SingleFavoritePlaceScreen({super.key, required this.favoritePlace});

  @override
  State<SingleFavoritePlaceScreen> createState() =>
      _SingleFavoritePlaceScreenState();
}

class _SingleFavoritePlaceScreenState extends State<SingleFavoritePlaceScreen> {
  final List<Marker> _markers = [];

  addMaker(LatLng point) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _markers.add(
          Marker(
            width: 75,
            height: 75,
            point: point,
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: Colors.red,
            ),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    addMaker(
        LatLng(widget.favoritePlace.latitude!, widget.favoritePlace.latitude!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritePlacesBloc, FavoritePlaceState>(
      listener: (context, evevt) {
        if (evevt is FavoritePlaceDeleted) {
          popNav();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const IconButton(
              onPressed: popNav,
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              )),
          actions: [
            IconButton(
              onPressed: () {
                context
                    .read<FavoritePlacesBloc>()
                    .add(DeleteFavoritePlace(widget.favoritePlace));
              },
              icon: const Icon(
                Icons.delete,
                color: kPrimaryColor,
              ),
            )
          ],
          title: const Text(
            "Favorite Place",
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kPrimaryLightColor,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            titleWidget(),
            const SizedBox(
              height: 20,
            ),
            imageWidget(),
            descriptionWidget(),
            mapWidget(),
            const SizedBox(
              height: 20,
            ),
            AddFavoritePlaceButton(
              title: 'Edit favorite place',
              onTapFunction: () {
                pushNav(AddFavoritePlaceScreen(
                  favoritePlaceModel: widget.favoritePlace,
                ));
              },
            )
          ],
        )),
      ),
    );
  }

  Widget titleWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        widget.favoritePlace.title != null ? widget.favoritePlace.title! : "",
        style: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: kPrimaryColor),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: FileImage(widget.favoritePlace.imageFile!),
              fit: BoxFit.cover)),
    );
  }

  Widget descriptionWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      child: Text(
        widget.favoritePlace.description != null
            ? widget.favoritePlace.description!
            : "",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget mapWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 250,
      width: double.infinity,
      child: IgnorePointer(
        ignoring: true,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(widget.favoritePlace.latitude!,
                widget.favoritePlace.longitude!),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: _markers)
          ],
        ),
      ),
    );
  }
}
