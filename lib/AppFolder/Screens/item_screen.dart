// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/Screens/favourite_scr.dart';
import 'package:chat_app/AppFolder/Screens/pickedImage.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../widgets/navigator.dart';
import 'cart_scr.dart';

class itemScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  CategoryModel product;
  itemScreen(
    this.product,
  );
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = AppCubit.get(context).commentsList;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {
                      // AppCubit.get(context).commentsList = null;
                      AppCubit.get(context).flag = false;

                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).commentsList = null;

                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.shopping_cart))
                ]),

            body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: PageView.builder(
                          itemCount: product.images!.length,
                          controller: _controller,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Image(
                                  image:
                                      NetworkImage("${product.images![index]}"),
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: SmoothPageIndicator(
                                    controller: _controller,
                                    count: product.images!.length,
                                    effect: ExpandingDotsEffect(
                                        dotColor: Colors.grey,
                                        activeDotColor: header,
                                        dotWidth: 10,
                                        // activeDotColor: Color(0xff8c7851)
                                        dotHeight: 10),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.name}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${product.description}",
                              maxLines: 3,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.price} EP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: RatingBar.builder(
                                    itemSize: 20,
                                    initialRating: product.rate!.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // divider(),
                            Container(
                              width: double.infinity,
                              color: Colors.grey[300],
                              height: 1,
                            ),

                            // Container(
                            //   height: 1,
                            //   width: double.infinity,
                            //   color: Colors.grey,
                            // ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery By: ",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 109, 109, 109),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  product.delivered.toString(),
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            // TextButton(
                            //     onPressed: () {
                            //       AppCubit.get(context).getComment(product.pid);
                            //     },
                            //     child: Text("Read more comments")),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   itemBuilder: (context, index) {
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Text(
                            //                 list[index].name!,
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.w500,
                            //                     fontSize: 16),
                            //               ),
                            //               Spacer(),
                            //               Text(DateFormat('MMM d, h:mm a')
                            //                   .format(DateTime
                            //                       .fromMicrosecondsSinceEpoch(
                            //                           list[index]
                            //                               .delivered!
                            //                               .toDate()
                            //                               .microsecondsSinceEpoch))
                            //                   .toString())
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             height: 20,
                            //           ),
                            //           Text(
                            //             list[index].comment!,
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 18),
                            //           )
                            //         ],
                            //       ),
                            //     );
                            //   },
                            //   itemCount: list!.length,
                            // )
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          AppCubit.get(context).getComment(product.pid);
                          AppCubit.get(context).changeFlag();
                        },
                        child: Container(
                          color: AppCubit.get(context).flag
                              ? Color.fromARGB(255, 243, 243, 243)
                              : Colors.white,
                          child: Row(
                            children: [
                              Text(
                                "See Reviews",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Spacer(),
                              !AppCubit.get(context).flag
                                  ? Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 40,
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 40,
                                      fill: 0.5,
                                    )
                            ],
                          ),
                        ),
                      ),
                      AppCubit.get(context).flag
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),

                                  list.isNotEmpty
                                      ? Container(
                                          // color: Color.fromARGB(
                                          //     255, 252, 252, 252),
                                          height: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    list[index].name!,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    DateFormat('MMM d, h:mm a')
                                                        .format(list[index]
                                                            .delivered!
                                                            .toDate())
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                list[index].comment!,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 60,
                                          child: Center(
                                            child: Text("No comment"),
                                          ),
                                        ),
                                  // ListView.builder(
                                  //     shrinkWrap: true,
                                  //     physics: NeverScrollableScrollPhysics(),
                                  //     itemCount: 1,
                                  //     itemBuilder: (context, index) =>
                                  //         Container(
                                  //       height: 60,
                                  //       child: Center(
                                  //         child: Text("No comment"),
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              if (list!.isEmpty && AppCubit.get(context).flag)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("No comments"),
                    ),
                  ),
                ),
              if (AppCubit.get(context).flag)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            controller: commentController,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(hintText: "Write a comment"),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              AppCubit.get(context).MakeComment(product.pid,
                                  DateTime.now(), commentController.text);
                              AppCubit.get(context).getComment(product.pid);
                            } else {
                              null;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
            ]),

            // body: Container(),

            bottomNavigationBar: Material(
              elevation: 10,
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MainColor // Background color
                              ),
                          onPressed: () {
                            navigateTo(
                                context,
                                PickedImagesScreen(
                                  product: product,
                                ));
                          },
                          child: Text('Try It'),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MainColor // Background color
                              ),
                          onPressed: () {
                            AppCubit.get(context).changeCartProducts(product);
                          },
                          child: Text('Add to Bag'),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
