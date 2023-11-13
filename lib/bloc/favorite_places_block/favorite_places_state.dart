part of 'favorite_places_bloc.dart';

abstract class FavoritePlaceState {}

class FavoritePlacesInitial extends FavoritePlaceState {}

class FavoritePlacesLoaded extends FavoritePlaceState {
  final List<FavoritePlaceModel> places;

  FavoritePlacesLoaded(this.places);
}

class FavoritePlaceAdded extends FavoritePlaceState {}

class FavoritePlaceDeleted extends FavoritePlaceState {}

class FavoritePlaceUpdated extends FavoritePlaceState {}

class FavoritePlacesError extends FavoritePlaceState {
  final String message;

  FavoritePlacesError(this.message);
}
