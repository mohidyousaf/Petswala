import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class PetPage extends StatefulWidget {
  final mongo.ObjectId petID;
  const PetPage({ Key key, this.petID }) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
        appBar: AppBar(
          title: Logo(color: AppColor.primary),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: AppBorderRadius.all_20),
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColor.white,
                    size: 30,
                  )),
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
        body: Container(
          height: 100
      ),
    );
  }
}