part of 'map_bloc.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapAnimating extends MapState {
  final LatLng position;
  MapAnimating(this.position);
}
