import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/screens/userProfile.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/Widgets/textfield.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => UserProfile())),
          icon: Image.asset('assets/back.png'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text('Settings', style: AppFont.h4(AppColor.black)),
            SizedBox(height: 32),
            Row(
              children: [
                Icon(Icons.account_circle_rounded, size: 30),
                SizedBox(width: 8),
                Text('Account', style: AppFont.h5(AppColor.black))
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 16),
            changewidget(
                'Change UserName', 'Enter new UserName', 'New UserName'),
            changewidget('Change Email', 'Enter new Email', "New Email"),
            changewidget(
                'Change Password', 'Enter new Password', 'New Password'),
          ],
        ),
      ),
    );
  }

  Padding changewidget(text, title, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  title: Text(title),
                  content: Container(
                    height: 180,
                    child: Column(
                      children: [
                        TextField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: title,
                            labelText: label,
                          ),
                        ),
                        SizedBox(height: 30),
                        buildButton('Confirm')
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(text, style: AppFont.bodySmall(AppColor.black)),
            IconButton(
                onPressed: () {
                  //edit
                },
                icon: Icon(Icons.arrow_right))
          ]),
          decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}
