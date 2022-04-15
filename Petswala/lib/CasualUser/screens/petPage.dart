import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/CasualUser/blocs/adoption_bloc.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PetPage extends StatefulWidget {
  const PetPage({ Key key}) : super(key: key);

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
    // print('hello: '+ModalRoute.of(context).settings.arguments);
    mongo.ObjectId petId = ModalRoute.of(context).settings.arguments;
    int index = BlocProvider.of<AdoptionBloc>(context).state.pets.indexWhere(
      (element) => element.petId == petId);
    PetInfo pet = index >= 0?BlocProvider.of<AdoptionBloc>(context).state.pets[index]:null;
    return Scaffold(
      bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomScrollView(
            controller: controller,
  
              slivers: [
                SliverAppBar(
                  stretch: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                backgroundColor: const Color(0xff1c0436),
                pinned: true,
                floating: true,
                leading: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.gray_dark.withOpacity(0.5),
                        borderRadius: AppBorderRadius.all_25
                      ),
                      child: Icon(
                      CupertinoIcons.back,
                      color: AppColor.white,
                      size: 30,
                      ),
                    ),
                  ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Opacity(
                    opacity: 0.2,
                    child: Text('helloS')),
                  background: CarouselSlider(
                    
                      options: CarouselOptions(
                        height: 350,
                        viewportFraction: 1,
                        // aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
                        ),
                      items: [
                        pet.category == 'Cat' ? 
                        Image.asset('assets/cat.png',fit: BoxFit.cover,width: MediaQuery.of(context).size.width,):
                        Image.asset('assets/images.jpg', width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)
                        ]
                    ),
                ),
                ),
                SliverList(delegate: SliverChildListDelegate(List.generate(10, (index) => CustomWidget(index)).toList())),
              ]),
              Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: Row(
                children: [
                  GestureDetector(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String userID = prefs.getString('name');
                          StreamChatClient client = await getChatClient();
                          Channel channel = await navigateToChannel(client, userID, pet.ownerName);
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatNavigator(client: client),
                                    settings: RouteSettings(name: '/channel',arguments: channel)),);
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_20
                          ),
                          child: Transform.rotate(
                            angle: -math.pi/4,
                            child: Icon(
                            Icons.send_rounded,
                            color: AppColor.white,
                            size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 60,
                          width: 300,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_20
                          ),
                          child: Center(child: Text('Adopt Pet', style: AppFont.h5(AppColor.white)))
                        ),
                      ),
                  
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

// bottomNavigationBar: HideableNavBar(
//             controller: controller, child: BottomNavBar(context)),
//         appBar: AppBar(
//           title: Logo(color: AppColor.primary),
//           leading: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: AppColor.primary,
//                       borderRadius: AppBorderRadius.all_20),
//                   child: Icon(
//                     CupertinoIcons.back,
//                     color: AppColor.white,
//                     size: 30,
//                   )),
//             ),
//           ),
//           backgroundColor: Color.fromRGBO(250, 250, 250, 1),
//           elevation: 0,
//         ),
//         body: Container(
//           child: Column(
//             children: [
                
//             ]),
//       ),

class CustomWidget extends StatelessWidget {
  CustomWidget(this._index) {
    debugPrint('initialize: $_index');
  }

  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: (_index % 2 != 0) ? Colors.white : Colors.grey,
      child: Center(child: Text('index: $_index', style: TextStyle(fontSize: 40))),
    );
  }
}