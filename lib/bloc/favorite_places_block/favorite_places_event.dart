part of 'favorite_places_bloc.dart';

abstract class FavoritePlaceEvent {}

class LoadFavoritePlaces extends FavoritePlaceEvent {}

class AddFavoritePlace extends FavoritePlaceEvent {
  final FavoritePlaceModel place;

  AddFavoritePlace(this.place);
}

class DeleteFavoritePlace extends FavoritePlaceEvent {
  final FavoritePlaceModel place;

  DeleteFavoritePlace(this.place);
}

class UpdateFavoritePlace extends FavoritePlaceEvent {
  final FavoritePlaceModel oldPlace;
  final FavoritePlaceModel newPlace;

  UpdateFavoritePlace(this.oldPlace, this.newPlace);
}
