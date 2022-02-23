
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/events/rescueEvent.dart';
import 'package:petswala/CasualUser/states/rescueState.dart';

class RescueBloc extends Bloc<RescueEvent, RescueState> {
  RescueBloc() : super(RescueState.initial()) {
    on<ChangeNameEvent>((event, emit) {
      
    });
  }
}