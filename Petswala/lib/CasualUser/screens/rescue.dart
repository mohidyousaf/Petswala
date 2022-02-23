import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/rescueBloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/events/rescueEvent.dart';
import 'package:petswala/CasualUser/states/rescueState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class RescueHome extends StatefulWidget {
  const RescueHome({Key key}) : super(key: key);

  @override
  _RescueHomeState createState() => _RescueHomeState();
}

class _RescueHomeState extends State<RescueHome> {
  bool x = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RescueBloc(),
      child: Scaffold(
          bottomNavigationBar: BottomNavBar(context),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMapScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: x ? 500 : 200,
                  decoration: BoxDecoration(
                      color: AppColor.secondary_extraLight,
                      borderRadius: AppBorderRadius.all_30),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RescueInput(
                              hintText: 'name', func: RescueFuncs.changeName),
                          SizedBox(height: 16,),
                          RescueInput(
                              hintText: 'name', func: RescueFuncs.changeName),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Container(
                  child: GestureDetector(
                      onTap: () => setState(() => x = x ? false : true),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColor.secondary_extraLight,
                            borderRadius: AppBorderRadius.all_30),
                        child: Text('Hello'),
                      )),
                ),
              ),
            ],
          )),
    );
  }
}

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const _initialPosition =
      CameraPosition(target: LatLng(37.77392, -122.431297), zoom: 11.5);
  GoogleMapController _googleMapController;
  Marker origin;
  Marker destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Location _location = Location();
  LocationData l;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => _googleMapController = controller,
      onLongPress: _addMarker,
      markers: {
        if (origin != null) origin,
      },
    );
  }

  void _addMarker(LatLng pos) async {
    {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      print(pos.latitude);
      setState(() {
        origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Rescue Location'),
          icon: BitmapDescriptor.defaultMarker,
          position: pos,
        );

        // Reset info
      });
    }
  }

  Future getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData current = await _location.getLocation();
    setState(() {
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(current.latitude, current.longitude),
              zoom: 11.5)));
    });
  }
}

class RescueInput extends StatelessWidget {
  final Function func;
  final hintText;
  const RescueInput({Key key, this.hintText, this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RescueBloc, RescueState>(
      builder: (context, state) {
        return CustomTextFormField(
          func: func,
          hintText: hintText,
          isValid: state,
        );
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key key, this.func, this.hintText, this.isValid})
      : super(key: key);

  final Function func;
  final hintText;
  final isValid;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: TextFormField(
        onChanged: (text) {
          // print(isValid.passIsValid);
          func(context, text);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          fillColor: AppColor.gray_transparent,
          filled: true,
          hintText: hintText,
          // errorText: isValid.passIsValid ? null : 'Wrong Input',
          hintStyle: AppFont.bodyLarge(AppColor.gray_light),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary),
              borderRadius: AppBorderRadius.all_20),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray_transparent),
              borderRadius: AppBorderRadius.all_20),
        ),
      ),
    );
  }
}

class RescueFuncs {
  static void changeName(context, text) {
    BlocProvider.of<RescueBloc>(context).add(ChangeNameEvent(name: text));
  }

  static void changeCategory(context, text) {
    BlocProvider.of<RescueBloc>(context).add(ChangeNameEvent(name: text));
  }

  static void changePrice(context, text) {
    BlocProvider.of<RescueBloc>(context).add(ChangeNameEvent(name: text));
  }

  static void changeQuantity(context, text) {
    BlocProvider.of<RescueBloc>(context).add(ChangeNameEvent(name: text));
  }
}
