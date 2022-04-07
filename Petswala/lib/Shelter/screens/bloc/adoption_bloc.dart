import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../../events/adoption_event.dart';
part '../../states/adoption_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  AdoptionBloc() : super(AdoptionInitial()) {
    on<AdoptionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
