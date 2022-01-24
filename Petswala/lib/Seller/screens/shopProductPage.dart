import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/Seller/widgets/sellerNavBars.dart';
import 'package:petswala/Seller/blocs/productBloc.dart';
import 'package:petswala/Seller/events/productEvent.dart';
import 'package:petswala/Seller/states/productState.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mongo.ObjectId id = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => ProductBloc()..add(InitProductEvent(id: id)),
      child: Builder(
        builder: (context) => Scaffold(
            bottomNavigationBar: BottomNavBar(context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/shop');
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: AppBorderRadius.all_25),
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  color: AppColor.white,
                                  size: 30,
                                ))),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Logo(color: AppColor.primary)),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    return state.product == null
                        ? Text('name')
                        : Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: AppBorderRadius.all_50),
                                child: Image.asset(
                                  state.product.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                                height: 200,
                                clipBehavior: Clip.hardEdge,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Name:  ',
                                            style: AppFont.bodyLarge(
                                                AppColor.gray_dark)),
                                        state.editable == null
                                            ? Text('name')
                                            : state.editable
                                                ? Flexible(
                                                    fit: FlexFit.loose,
                                                    child: BlocBuilder<
                                                        ProductBloc,
                                                        ProductState>(
                                                      builder:
                                                          (context, state) {
                                                        return TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = state
                                                                    .product
                                                                    .name,
                                                          onChanged: (text) {
                                                            // print(text);
                                                            BlocProvider.of<
                                                                        ProductBloc>(
                                                                    context)
                                                                .add(ChangeNameEvent(
                                                                    name:
                                                                        text));
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            fillColor: AppColor
                                                                .gray_transparent,
                                                            filled: true,
                                                            hintText:
                                                                'New Post',
                                                            hintStyle: AppFont
                                                                .bodyLarge(AppColor
                                                                    .gray_light),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .primary),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .gray_transparent),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                                    child: Text(state.product.name,
                                                        style:AppFont.bodyLarge(AppColor.black)),
                                                  ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Category:  ',
                                            style: AppFont.bodyLarge(
                                                AppColor.gray_dark)),
                                        state.editable == null
                                            ? Text('name')
                                            : state.editable
                                                ? Flexible(
                                                    fit: FlexFit.loose,
                                                    child: BlocBuilder<
                                                        ProductBloc,
                                                        ProductState>(
                                                      builder:
                                                          (context, state) {
                                                        return TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = state
                                                                    .product
                                                                    .category,
                                                          onChanged: (text) {
                                                            // print(text);
                                                            BlocProvider.of<
                                                                        ProductBloc>(
                                                                    context)
                                                                .add(ChangeCategoryEvent(
                                                                    category:
                                                                        text));
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            fillColor: AppColor
                                                                .gray_transparent,
                                                            filled: true,
                                                            hintText:
                                                                'New Post',
                                                            hintStyle: AppFont
                                                                .bodyLarge(AppColor
                                                                    .gray_light),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .primary),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .gray_transparent),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                        state.product.category,
                                                        style:
                                                            AppFont.bodyLarge(
                                                                AppColor
                                                                    .black)),
                                                  ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Price: Rs.  ',
                                            style: AppFont.bodyLarge(
                                                AppColor.gray_dark)),
                                        state.editable == null
                                            ? Text('name')
                                            : state.editable
                                                ? Flexible(
                                                    fit: FlexFit.loose,
                                                    child: BlocBuilder<
                                                        ProductBloc,
                                                        ProductState>(
                                                      builder:
                                                          (context, state) {
                                                        return TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = '${state
                                                                    .product
                                                                    .price}',
                                                          onChanged: (text) {
                                                            // print(text);
                                                            BlocProvider.of<
                                                                        ProductBloc>(
                                                                    context)
                                                                .add(ChangePriceEvent(
                                                                    price:
                                                                        double.parse(text)));
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            fillColor: AppColor
                                                                .gray_transparent,
                                                            filled: true,
                                                            hintText:
                                                                'New Post',
                                                            hintStyle: AppFont
                                                                .bodyLarge(AppColor
                                                                    .gray_light),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .primary),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .gray_transparent),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                        '${state.product.price}',
                                                        style:
                                                            AppFont.bodyLarge(
                                                                AppColor
                                                                    .black)),
                                                  ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Quantity:  ',
                                            style: AppFont.bodyLarge(
                                                AppColor.gray_dark)),
                                        state.editable == null
                                            ? Text('name')
                                            : state.editable
                                                ? Flexible(
                                                    fit: FlexFit.loose,
                                                    child: BlocBuilder<
                                                        ProductBloc,
                                                        ProductState>(
                                                      builder:
                                                          (context, state) {
                                                        return TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = '${state
                                                                    .product
                                                                    .quantity}',
                                                          onChanged: (text) {
                                                            // print(text);
                                                            BlocProvider.of<
                                                                        ProductBloc>(
                                                                    context)
                                                                .add(ChangeQuantityEvent(
                                                                    quantity:
                                                                        int.parse(text)));
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            fillColor: AppColor
                                                                .gray_transparent,
                                                            filled: true,
                                                            hintText:
                                                                'New Post',
                                                            hintStyle: AppFont
                                                                .bodyLarge(AppColor
                                                                    .gray_light),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .primary),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                        .gray_transparent),
                                                                borderRadius:
                                                                    AppBorderRadius
                                                                        .all_20),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                        '${state.product.quantity}',
                                                        style:
                                                            AppFont.bodyLarge(
                                                                AppColor
                                                                    .black)),
                                                  ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Rating:  ',
                                            style: AppFont.bodyLarge(
                                                AppColor.gray_dark)),
                                        Text('${state.product.rating}',
                                            style: AppFont.bodyLarge(
                                                AppColor.black)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                  }),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      return state.editable != null ? state.editable ?
                      GestureDetector(
                        onTap: () async {
                          Bloc bloc = BlocProvider.of<ProductBloc>(context);
                          bloc.add(CompleteEditEvent());
                        },
                        child: Container(
                          width: 350,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.all_20,
                              color: AppColor.primary),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          child: Center(
                            child: Text('Done',
                                style: AppFont.button(AppColor.white)),
                          ),
                        ),
                      ):
                      GestureDetector(
                        onTap: () async {
                          Bloc bloc = BlocProvider.of<ProductBloc>(context);
                          bloc.add(MakeEditableEvent());
                        },
                        child: Container(
                          width: 350,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.all_20,
                              color: AppColor.primary),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          child: Center(
                            child: Text('Edit Item',
                                style: AppFont.button(AppColor.white)),
                          ),
                        ),
                      ):Text('hello');
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
