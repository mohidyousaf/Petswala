import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/CasualUser/blocs/adoption_bloc.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

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
      body: CustomScrollView(
        controller: controller,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColor.white,
              pinned: true, 
              automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Icon(
                    CupertinoIcons.back,
                    color: AppColor.primary,
                    size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30.0),
                      child: Logo(color:AppColor.primary),
                    ),
                  ],
                ),
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  title: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                      CupertinoIcons.back,
                      color: AppColor.primary,
                      size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30.0),
                      child: Logo(color:AppColor.primary),
                    ),
                  ],
                ),
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: pet.category == 'Cat' ? Image.asset('assets/cat.png'):
                            Image.asset('assets/images.jpg', fit: BoxFit.fitWidth,)
                      ),
                      Positioned(
                        bottom: 16,
                        child: Text('Available seats')),
                    ]
                  ),
                )
            ),
            SliverList(delegate: SliverChildListDelegate(List.generate(10, (index) => CustomWidget(index)).toList())),
          ])
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