
import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';

class AdoptionState extends Equatable{
  final List<PetInfo> pets;
  final List<PetInfo> displayedPets;
  @override
  List<Object> get props => [pets]; 

  AdoptionState._({this.pets: const [], this.displayedPets: const []});

  factory AdoptionState.initial(
      {List<PetInfo> pets: const [], List<PetInfo> displayedPets: const []}) {
    return AdoptionState._(pets: pets, displayedPets: displayedPets);
  }

}
