import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/Widgets/textfield.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/bloc/register_bloc.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:provider/provider.dart';

// Signup of our app has validations as well for the username, email and password.

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool visible = true;
  String dropdownvalue = 'Simple User';
  var items = ['Simple User', 'Vet', 'Shelter', 'Seller'];
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBLoc>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 138, 128, 1),
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusNode currentfocus = FocusScope.of(context);
            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/Sign Up.png'),
              alignment: Alignment.topLeft,
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'REGISTER ACCOUNT',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(250, 250, 250, 1),
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    SizedBox(height: 30),
                    StreamBuilder<Object>(
                        stream: bloc.userName,
                        builder: (context, snapshot) {
                          return TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter User Name',
                                labelText: 'User Name',
                                errorText: snapshot.error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) => {bloc.changeUserNAme(value)},
                          );
                        }),
                    SizedBox(height: 16),
                    StreamBuilder<Object>(
                        stream: bloc.email,
                        builder: (context, snapshot) {
                          return TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter New Email',
                                labelText: 'Email',
                                errorText: snapshot.error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) => {bloc.changeEmail(value)},
                          );
                        }),
                    SizedBox(height: 16),
                    StreamBuilder<Object>(
                        stream: bloc.password,
                        builder: (context, snapshot) {
                          return TextField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: visible,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter New Password',
                                labelText: 'Password',
                                errorText: snapshot.error,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffix: IconButton(
                                  icon: visible
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                )),
                            onChanged: (value) => {bloc.changePassword(value)},
                          );
                        }),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          // color: AppColor.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Register as ',
                                style: AppFont.bodyLarge(AppColor.primary)),
                            StreamBuilder<Object>(
                                stream: bloc.type,
                                builder: (context, snapshot) {
                                  bloc.changeType(dropdownvalue);
                                  return DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue,
                                    hint: Text('Register as'),
                                    style: AppFont.button(
                                        Color.fromARGB(255, 80, 77, 77)),
                                    borderRadius: BorderRadius.circular(20),

                                    // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromARGB(255, 80, 77, 77),
                                    ),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownvalue = newValue;
                                        bloc.changeType(dropdownvalue);
                                        print(dropdownvalue);
                                        print(bloc.type);
                                      });
                                    },
                                  );
                                }),
                          ]),
                    ),
                    SizedBox(height: 24),
                    StreamBuilder<bool>(
                        stream: bloc.isValid,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: snapshot.hasError
                                ? null
                                : () async {
                                    bloc.submit();
                                    dropdownvalue == 'Simple User'
                                        ? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => AddPet()))
                                        : Null;
                                  },
                            child: Container(
                              width: 300,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: snapshot.hasError
                                    ? Colors.grey
                                    : Color.fromRGBO(85, 68, 119, 1),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'NEXT',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        letterSpacing: 1.25,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 16),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: 'Already have an account?'),
                      WidgetSpan(child: SizedBox(width: 5)),
                      TextSpan(
                          text: 'Login Here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            })
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
