import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'dart:math' as math;

class ServicesHome extends StatelessWidget {
  const ServicesHome({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
        }},
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(context),
          body:Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(color:AppColor.primary),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Builder(builder: (context) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextField(
                              minLines: 1,
                              maxLines: 3,
                              onChanged: (text) {
                                // print(text);
                                // BlocProvider.of<PostBloc>(context).add(ChangeNewPostTextEvent(text:text));
                              },
                              decoration: InputDecoration(   
                                contentPadding: EdgeInsets.all(20),
                                fillColor: AppColor.gray_transparent,
                                filled: true,
                                hintText: 'New Post',
                                hintStyle: AppFont.bodyLarge(AppColor.gray_light),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.primary),
                                    borderRadius: AppBorderRadius.all_20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.gray_transparent),
                                    borderRadius: AppBorderRadius.all_20),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left:16),
                          child: InkWell(
                            onTap: () {
                              // BlocProvider.of<PostBloc>(context).add(AddPostEvent());
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                currentFocus.focusedChild.unfocus();                                           
                              }},
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primary, 
                                borderRadius: AppBorderRadius.all_15),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,19.5,19,19.5),
                                child: Transform.rotate(
                                  angle: -math.pi/5,
                                  child: Icon(Icons.send, color: AppColor.white,)),
                              )),
                          ),
                        )
                        ],
                      );
                      }),
                  )
                ],
              ),
            ),
          ),
          

        ),
      );
  }
}