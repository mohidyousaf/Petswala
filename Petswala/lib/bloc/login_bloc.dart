import 'dart:async';
import 'dart:core';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/bloc/validation.dart';
import 'package:petswala/demo.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
// defining a dummy name and password

  // APi call
  // String name = 'mohid';
  // String pass = '123';
  var users = [];
  Future _doneInitialization;

  // Constructor
  LoginBloc(){
    _doneInitialization = getUserData();
  }


// define controllers
  final _loginUserName = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();
  final _loginState = BehaviorSubject<bool>();

// define getters

  Stream<String> get userName => _loginUserName.stream.transform(nameValidator);
  Stream<String> get password =>
      _loginPassword.stream.transform(passwordValidator);

  Stream<bool> get loginState => _loginState.stream;

  Stream<bool> get isValid =>
      Rx.combineLatest2(userName, password, (a, b) => true);

// define setters

  // void test(String user) {
  //   print('i am here');
  //   _loginUserName.sink.add(user);
  // }
  //
  // void test2(String password) {
  //   print('i am here');
  //   _loginPassword.sink.add(password);
  // }

  Function(String) get changeUserName => _loginUserName.sink.add;
  Function(String) get changePassword => _loginPassword.sink.add;

// password submission
  Future getUserData() async{
    var db = await DBConnection.getInstance();
    users = await db.getUsers();
  }

  Future get initDone => _doneInitialization;

  Future<bool> submit() async {
    print(_loginPassword.value);
    print(_loginUserName.value);

    String testName = _loginUserName.value;
    String testPassword = _loginPassword.value;

    print(users[0].name);

    bool check = false;
    await initDone;
    users.forEach((element) {
      if (element.name == testName) {
        if (element.password == testPassword) {
          check = true;
        }
      }
    });

    if (check) {
      _loginState.sink.add(true);
      print("credentials verified");
      return true;
    } else {
      _loginState.sink.add(false);
      print("credentials not verified");
      return false;
    }
  }

// dispose
  void dispose() {
    _loginPassword.close();
    _loginUserName.close();
    _loginState.close();
  }
}
