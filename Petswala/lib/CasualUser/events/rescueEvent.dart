abstract class RescueEvent{}

class ChangeNameEvent extends RescueEvent {
  final String name;
  ChangeNameEvent({this.name});
}