import 'package:equatable/equatable.dart';

class RescueState extends Equatable {

  final int x;
  @override
  List<Object> get props => [x]; 

  RescueState._({this.x});

  factory RescueState.initial() {
    return RescueState._();
  }
}
