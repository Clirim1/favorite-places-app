import 'package:favorite_places_app/bloc/map_bloc/map_bloc.dart';
import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/single_favorite_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class FavoritePlaceCard extends StatelessWidget {
  final FavoritePlaceModel favoritePlace;
  const FavoritePlaceCard({super.key, required this.favoritePlace});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNav(SingleFavoritePlaceScreen(favoritePlace: favoritePlace));
      },
      child: SizedBox(
        width: 350,
        child: Card(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                width: 140,
                height: 230,
                child: Image.file(
                  favoritePlace.imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 180,
                      height: 35,
                      child: Text(
                        favoritePlace.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 175,
                      height: 80,
                      child: Text(
                        favoritePlace.description!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<MapBloc>().add(
                              AnimateToPosition(LatLng(favoritePlace.latitude!,
                                  favoritePlace.longitude!)),
                            );
                      },
                      child: Container(
                        width: 230,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Navigate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
