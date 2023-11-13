import 'package:favorite_places_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:favorite_places_app/bloc/map_bloc/map_bloc.dart';
import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/add_favorite_place_screen.dart';
import 'package:favorite_places_app/screens/favorite_place_widget/widgets/favorite_place_card.dart';
import 'package:favorite_places_app/screens/welcome_screen.dart';
import 'package:favorite_places_app/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FavoritePlacesWidget extends StatefulWidget {
  final List<FavoritePlaceModel> favoritePlaces;
  final List<Marker> markers;

  const FavoritePlacesWidget(
      {super.key, required this.favoritePlaces, required this.markers});

  @override
  State<FavoritePlacesWidget> createState() => _FavoritePlacesWidgetState();
}

class _FavoritePlacesWidgetState extends State<FavoritePlacesWidget> {
  //final List<Marker> _markers = [];

  final MapController _mapController = MapController();

  // void _addMarker(LatLng point) {
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         width: 75.0,
  //         height: 75.0,
  //         point: point,
  //         child: const Icon(
  //           Icons.location_on,
  //           color: Colors.red,
  //           size: 45,
  //         ),
  //       ),
  //     );
  //   });
  // }

  // createMkaersFromFavoritePlaces() {
  //   for (FavoritePlaceModel favoritePlace in widget.favoritePlaces) {
  //     _addMarker(LatLng(favoritePlace.latitude!, favoritePlace.longitude!));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //   createMkaersFromFavoritePlaces();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogOutSucess) {
              DatabaseHelper.instance.clearAllData();
              pushAndRemoveUntil(const WelcomeScreen(), '/WelcomeScreen');
            }
          },
        ),
        BlocListener<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapAnimating) {
              _mapController.move(state.position, 14);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryLightColor,
          centerTitle: true,
          title: const Text(
            "Favorite Places",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
              },
              icon: const Icon(
                Icons.logout,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(42.651576, 20.899031),
                initialZoom: 9.2,
              ),
              mapController: _mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: widget.markers)
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0.6),
                  child: widget.favoritePlaces.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.favoritePlaces.length,
                          itemBuilder: (context, index) {
                            return SafeArea(
                                child: FavoritePlaceCard(
                              favoritePlace: widget.favoritePlaces[index],
                            ));
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: const Text("No favorite places added!"),
                        ),
                )),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 220),
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {
              pushNav(const AddFavoritePlaceScreen());
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
