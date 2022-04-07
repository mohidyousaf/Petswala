import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/models/vaccinationInfo.dart';

class PetInfo{
  String name;
  DateTime dateOfBirth;
  int years;
  int months;
  PetStatus status;
  List<VaccinationInfo> vaccinations;
  List<String> allergies;
  List<Map<String, String>> medHistory;
  ObjectId petId;
  ObjectId ownerID;
}

enum PetStatus {
  inAdoption,
  inFostering,
  inShelter,
}