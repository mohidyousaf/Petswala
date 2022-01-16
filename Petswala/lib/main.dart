import 'package:flutter/material.dart';
//import 'package:toggle_bar/toggle_bar.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/Authentication/addPet2.dart';
import 'package:petswala/CasualUser/screens/userProfile.dart';
import 'package:petswala/bloc/pet_bloc.dart';
import 'package:petswala/bloc/register_bloc.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/boardingScreen.dart';
import 'package:petswala/profile.dart';
import 'package:petswala/map.dart';
import 'package:petswala/underMaintenance.dart';
import 'package:petswala/homescreen_Shop.dart';
import 'package:petswala/userMarketPlace.dart';
import 'package:petswala/SearchPage.dart';
import 'package:petswala/addItem.dart';
import 'package:petswala/newsFeed.dart';
import 'package:petswala/name.dart';
import 'package:petswala/DataBase.dart';
import 'package:petswala/demo.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/Authentication/signup.dart';
import 'package:petswala/Authentication/landingPage.dart';
import 'package:petswala/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HttpOverrides.global = new DevHttpOverrides();
  if (prefs.containsKey('name')) {
    var name = prefs.getString('name');
    var type = prefs.getString('type');
    print(name);
    print(type);
  }
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBLoc>(create: (context) => RegisterBLoc()),
        Provider<PetBLoc>(create: (context) => PetBLoc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LandingPage(),
          '/name': (context) => Name(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => UserProfile(),
          '/rescue': (context) => RescueMap(),
          '/maintenance': (context) => Maintenance(),
          '/shop': (context) => Shop(),
          '/market': (context) => Shop2(),
          '/search': (context) => Search(),
          '/feed': (context) => newsFeed(),
          '/addItem': (context) => AddItem(),
          '/login': (context) => Login(),
          '/boarding': (context) => Boarding(),
          '/addpet1': (context) => AddPet(),
          '/addpet2': (context) => AddPet2(),
        },
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      height: 200,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.red[300],
        elevation: 7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              //ImagrOverLay: AssetImage('assets/dogcollor.jpg'),
              //Image(image: AssetImage('assets/dogcollor.jpg'),
              leading: Icon(Icons.pets, size: 60),
              title: Text('Dog Collar', style: TextStyle(fontSize: 25.0)),
              subtitle: Text(
                  'size: M   '
                  'quantity:10\n'
                  'Price: Rs50\n ',
                  style: TextStyle(fontSize: 18.0)),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Edit'),
                  onPressed: () {/* ... */},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {/* ... */},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
