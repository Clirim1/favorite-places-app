import 'package:favorite_places_app/bloc/favorite_places_block/favorite_places_bloc.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';

import 'package:favorite_places_app/screens/favorite_place_widget/favorite_places_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FavoritePlaceModel> favoritePlaces = [];
  final List<Marker> _markers = [];

  @override
  void initState() {
    context.read<FavoritePlacesBloc>().add(LoadFavoritePlaces());
    super.initState();
  }

  createMkaersFromFavoritePlaces() {
    for (FavoritePlaceModel favoritePlace in favoritePlaces) {
      _addMarker(LatLng(favoritePlace.latitude!, favoritePlace.longitude!));
    }
  }

  void _addMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          width: 75.0,
          height: 75.0,
          point: point,
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 45,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritePlacesBloc, FavoritePlaceState>(
        listener: (context, state) {
          if (state is FavoritePlacesLoaded) {
            setState(() {
              favoritePlaces = state.places;
              createMkaersFromFavoritePlaces();
            });
          }
        },
        child: FavoritePlacesWidget(
          favoritePlaces: favoritePlaces,
          markers: _markers,
        ));
  }
}
