import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<AnimateToPosition>(_onAnimateToPosition);
  }

  void _onAnimateToPosition(AnimateToPosition event, Emitter<MapState> emit) {
    emit(MapAnimating(event.position));
  }
}
