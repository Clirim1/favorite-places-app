part of 'map_bloc.dart';

abstract class MapEvent {}

class AnimateToPosition extends MapEvent {
  final LatLng position;

  AnimateToPosition(this.position);
}
