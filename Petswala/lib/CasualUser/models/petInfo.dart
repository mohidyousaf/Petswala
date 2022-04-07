import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/models/vaccinationInfo.dart';

class PetInfo{
  String name;
  String category;
  String breed;
  DateTime dateOfBirth;
  bool forAdoption;
  int years;
  int months;
  PetStatus status;
  List<VaccinationInfo> vaccinations;
  List<String> allergies;
  List<Map<String, String>> medHistory;
  ObjectId petId;
  ObjectId ownerID;

  PetInfo({this.forAdoption:false, this.name, this.category, this.breed, this.dateOfBirth, this.years, this.months, 
  this.status, this.vaccinations, this.allergies, this.medHistory, this.petId, this.ownerID});

}

enum PetStatus {
  inAdoption,
  inFostering,
  inShelter,
}