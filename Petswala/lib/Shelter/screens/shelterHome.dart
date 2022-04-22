import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Shelter/blocs/adoption_bloc.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:percent_indicator/percent_indicator.dart';

class ShelterHome extends StatefulWidget {
  const ShelterHome({Key key}) : super(key: key);

  @override
  State<ShelterHome> createState() => _ShelterHomeState();
}

class _ShelterHomeState extends State<ShelterHome> {
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
    return BlocProvider(
      create: (context) => AdoptionBloc(),
      child: Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          bottomNavigationBar: HideableNavBar(
            child: BottomNavBar(context),
            controller: controller,
          ),
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('/home'),
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: AppBorderRadius.all_20),
                      child: Icon(
                        CupertinoIcons.back,
                        color: AppColor.white,
                        size: 30,
                      )),
                ),
                Logo(color: AppColor.primary),
              ],
            ),
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            elevation: 0,
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Harold\'s Shelter',
                    style: AppFont.h4(AppColor.color_font_dark),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: AppBorderRadius.all_25,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.001,
                          blurRadius: 7,
                          color: AppColor.gray_light.withAlpha(50))
                    ]),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: AppBorderRadius.all_20,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 4,
                                color: AppColor.gray_light)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Rescues',
                                style: AppFont.bodySmall(AppColor.white),
                              ),
                              Text(
                                '15',
                                style: AppFont.h4(AppColor.white),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'For Adoption',
                                style: AppFont.bodySmall(AppColor.white),
                              ),
                              Text(
                                '15',
                                style: AppFont.h4(AppColor.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 15.0,
                          percent: 0.7,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "20",
                                style: AppFont.h5(AppColor.color_font_dark),
                              ),
                              Text(
                                "available",
                                style: AppFont.caption(AppColor.gray_light),
                              ),
                            ],
                          ),
                          backgroundColor: AppColor.secondary_light,
                          progressColor: AppColor.primary,
                          animation: true,
                        ),
                        Text(
                          'Capacity',
                          style: AppFont.button(AppColor.color_font_dark),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text('Rescued Animals',
                      style: AppFont.h4(
                        AppColor.color_font_dark,
                      )),
                )),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: ((context, index) => ShelterPetCard()),
                itemCount: 5,
              ),
            ),
          ])),
    );
  }
}

class ShelterPetCard extends StatelessWidget {
  const ShelterPetCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: AppBorderRadius.all_20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppBorderRadius.all_20),
                  height: 75,
                  width: 75,
                  child: Image.asset(
                    'assets/cat.png',
                    fit: BoxFit.fill,
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Howard',
                      style: AppFont.bodyLarge(AppColor.color_font_dark),
                    ),
                    Text(
                      'Cat',
                      style: AppFont.bodySmall(AppColor.gray_light),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: AppBorderRadius.all_20),
              height: 50,
              width: 100,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Injured',
                    style: AppFont.button(AppColor.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// class 