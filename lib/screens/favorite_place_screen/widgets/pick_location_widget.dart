import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/widgets/location_widget.dart';
import 'package:favorite_places_app/screens/favorite_place_screen/widgets/title_widget.dart';
import 'package:favorite_places_app/widgets/overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class PickLocationWidget extends StatefulWidget {
  final Function(LatLng point) createMakerFunction;
  final LatLng? point;
  const PickLocationWidget(
      {super.key, required this.createMakerFunction, this.point});

  @override
  State<PickLocationWidget> createState() => _PickLocationWidgetState();
}

class _PickLocationWidgetState extends State<PickLocationWidget> {
  final List<Marker> _markers = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    checkForPoint();
    super.initState();
  }

  checkForPoint() {
    if (widget.point != null) {
      setState(() {
        _markers.add(
          Marker(
            width: 75,
            height: 75,
            point: widget.point!,
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: Colors.red,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWidget(title: "Pick Location"),
        IgnorePointer(
          child: Container(
            height: 120,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/mapImage.jpg",
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
            child: _markers.isNotEmpty
                ? FlutterMap(
                    options: MapOptions(
                      initialCenter: _markers[0].point,
                      initialZoom: 9.2,
                    ),
                    mapController: _mapController,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(markers: _markers)
                    ],
                  )
                : Container(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _getCurrentLocation(context);
                },
                child: const Text(
                  "Current Location",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
              InkWell(
                onTap: () {
                  pushNav(LocationWidget(
                    updatePreviewScreenMaker: addMaker,
                  ));
                },
                child: const Text(
                  "Pick from map",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  void _getCurrentLocation(BuildContext context) async {
    OverlayLoader.show(context);
    if (await requestPermission()) {
      Position position = await Geolocator.getCurrentPosition();

      LatLng point = LatLng(position.latitude, position.longitude);

      addMaker(point);
    } else {
      print('Location permission not granted');
    }
    OverlayLoader.hide(context);
  }

  addMaker(LatLng point) {
    widget.createMakerFunction(point);
    _markers.clear();
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
    if (_markers.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _mapController.move(point, 9.4);
      });
    }
  }
}
