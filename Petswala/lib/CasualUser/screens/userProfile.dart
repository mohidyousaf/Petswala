import 'package:flutter/material.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  double containerHeight = 150;
  double avatarHeight = 100;

  @override
  Widget build(BuildContext context) {
    double top = containerHeight - avatarHeight / 2;
    return Scaffold(
      appBar: _topbar(null),
      body: Column(
        children: [
          _profile(top),
          SizedBox(height: 135),
          Container(
            // width: MediaQuery.of(context).size.width,
            child: ToggleSwitch(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: 60.0,
              fontSize: 16.0,
              initialLabelIndex: 1,
              activeBgColor: [AppColor.primary_dark],
              activeFgColor: Colors.white,
              inactiveBgColor: AppColor.gray_light,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 3,
              cornerRadius: 20,
              labels: ['Posts', 'About', 'Shopping'],
              icons: [Icons.post_add, Icons.info, Icons.shopping_bag],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _profile(double top) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: containerHeight,
          decoration: BoxDecoration(color: AppColor.primary_light),
        ),
        Positioned(
          top: top + 50,
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            // color: AppColor.white,
            decoration: BoxDecoration(color: AppColor.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 10, offset: Offset(1, 3))
            ]),
          ),
        ),
        Positioned(
          left: 20,
          top: top,
          child: Container(
            child: CircleAvatar(
              radius: avatarHeight / 2 + 2,
              backgroundColor: AppColor.gray_light,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/User.png'),
                backgroundColor: AppColor.white,
                radius: avatarHeight / 2,
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
            left: 24,
            top: top + 120,
            child: Container(
                child: Row(
              children: [
                Text(
                  "ADIL ASLAM",
                  style: AppFont.h5(AppColor.black),
                ),
                IconButton(
                    onPressed: () => {
                          // edit name
                        },
                    icon: Icon(Icons.edit)),
              ],
            ))),
        Positioned(
          top: top + 80,
          right: 16,
          child: GestureDetector(
            onTap: () {
              // switch the profile
            },
            child: Container(
              child: new Image.asset('assets/switch button.png'),
            ),
          ),
        )
      ],
    );
  }
}

Widget _topbar(function) {
  return AppBar(
    leading:
        IconButton(icon: Image.asset('assets/back.png'), onPressed: function),
    backgroundColor: AppColor.white,
    title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
    actions: [
      IconButton(
          icon: Icon(
            Icons.settings,
            color: AppColor.primary_dark,
          ),
          onPressed: () => {})
    ],
    centerTitle: true,
    elevation: 0,
  );
}
