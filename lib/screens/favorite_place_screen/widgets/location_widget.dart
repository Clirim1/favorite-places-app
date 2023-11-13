import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/widgets/add_favorite_place_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationWidget extends StatefulWidget {
  final Function(LatLng point) updatePreviewScreenMaker;

  const LocationWidget({super.key, required this.updatePreviewScreenMaker});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final List<Marker> _markers = [];

  void _addMarker(LatLng point) {
    _markers.clear();
    setState(() {
      _markers.add(
        Marker(
          width: 75.0,
          height: 75.0,
          point: point,
          child: const Icon(
            Icons.location_on,
            size: 50,
            color: Colors.red,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: const Text(
          "Pick location from map",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: kPrimaryColor),
        ),
        leading: const IconButton(
            onPressed: popNav,
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            )),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(42.651576, 20.899031),
              initialZoom: 9.2,
              onTap: (_, latLng) => _addMarker(latLng),
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
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AddFavoritePlaceButton(
                title: "Pick Location",
                onTapFunction: () {
                  if (_markers.length != 0) {
                    popNav();
                    widget.updatePreviewScreenMaker(_markers[0].point);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
