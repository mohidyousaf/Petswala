import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adoption_event.dart';
part 'adoption_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  AdoptionBloc() : super(AdoptionInitial()) {
    on<AdoptionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
