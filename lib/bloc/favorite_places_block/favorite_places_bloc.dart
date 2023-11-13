import 'package:favorite_places_app/models/favorite_place_model.dart';
import 'package:favorite_places_app/helpers/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_places_event.dart';
part 'favorite_places_state.dart';

class FavoritePlacesBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  List<FavoritePlaceModel> _places = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  FavoritePlacesBloc() : super(FavoritePlacesInitial()) {
    on<LoadFavoritePlaces>(_onLoadFavoritePlaces);
    on<AddFavoritePlace>(_onAddFavoritePlace);
    on<DeleteFavoritePlace>(_onDeleteFavoritePlace);
    on<UpdateFavoritePlace>(_onUpdateFavoritePlaces);
  }

  void _onLoadFavoritePlaces(
      LoadFavoritePlaces event, Emitter<FavoritePlaceState> emit) async {
    try {
      _places = await _databaseHelper.getPlaces();

      emit(FavoritePlacesLoaded(_places));
    } catch (e) {
      emit(FavoritePlacesError(e.toString()));
    }
  }

  void _onAddFavoritePlace(
      AddFavoritePlace event, Emitter<FavoritePlaceState> emit) async {
    _places.add(event.place);
    await _databaseHelper.addPlace(event.place);
    emit(FavoritePlacesLoaded(_places));
    emit(FavoritePlaceAdded());
  }

  void _onDeleteFavoritePlace(
      DeleteFavoritePlace event, Emitter<FavoritePlaceState> emit) async {
    await _databaseHelper.deleteFavoritePlace(event.place);
    _places.removeWhere((place) =>
        place.title == event.place.title &&
        place.latitude == event.place.latitude &&
        place.longitude == event.place.longitude);
    emit(FavoritePlaceDeleted());
    emit(FavoritePlacesLoaded(List.from(_places)));
  }

  void _onUpdateFavoritePlaces(
      UpdateFavoritePlace event, Emitter<FavoritePlaceState> emit) async {
    await _databaseHelper.updateFavoritePlace(event.oldPlace, event.newPlace);

    int index = _places.indexWhere((place) =>
        place.title == event.oldPlace.title &&
        place.latitude == event.oldPlace.latitude &&
        place.longitude == event.oldPlace.longitude);

    if (index != -1) {
      _places[index] = event.newPlace;
      emit(FavoritePlaceUpdated());
      emit(FavoritePlacesLoaded(List.from(_places)));
    }
  }
}
