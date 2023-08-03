// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart'; //بخ خلي بالك من نفسك
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/constants.dart';

class PickedImagesScreen extends StatefulWidget {
  CategoryModel product;
  PickedImagesScreen({
    required this.product,
  });

  @override
  State<PickedImagesScreen> createState() => _PickedImagesScreenState();
}

class _PickedImagesScreenState extends State<PickedImagesScreen> {
  // const PickedImagesScreen({super.key});
  var flag = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                AppCubit.get(context).isFinish = false;
                AppCubit.get(context).isLoading = false;
                AppCubit.get(context).imageURL = null;
                AppCubit.get(context).profileImage = null;

                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: MainColor,
              )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    AppCubit.get(context).PickImageFromGallery();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      color: Colors.grey[200],
                      child: AppCubit.get(context).imageURL == null
                          ? const Center(
                              child: Icon(
                                Icons.cloud_upload,
                                color: Color(0xff009999),
                                size: 50,
                              ),
                            )
                          : !AppCubit.get(context).isFinish &&
                                  !AppCubit.get(context).isLoading
                              ? Image.file(AppCubit.get(context).profileImage!,
                                  fit: BoxFit.cover)
                              : !AppCubit.get(context).isLoading
                                  ? widget.product.pid == '5spvt4bY1ub8U4uKeurt'
                                      ? Image.asset("assets/images/longsleeve.jpg")
                                      : Image.asset("assets/images/black.jpg")
                                  : Center(
                                      child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator()),
                                    ),
                      width: 300,
                      height: 400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AppCubit.get(context).imageURL == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RatingBar.builder(
                        itemSize: 20,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          AppCubit.get(context).allProducts!.forEach((element) {
                            if (element.pid == widget.product.pid) {
                              setState(() {
                                element.rate = rating;
                              });
                            }
                          });
                          AppCubit.get(context)
                              .updateRating(rating, widget.product.pid);
                        },
                      ),
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: MainColor // Background color
                    ),
                onPressed: AppCubit.get(context).imageURL == null
                    ? null
                    : () {
                        AppCubit.get(context).changeIsLoading();
                        Random random = new Random();
                        int randomNumber = random.nextInt(5) + 5;
                        Future.delayed(Duration(seconds: randomNumber), () {
                          AppCubit.get(context).changeIsLoading();
                          AppCubit.get(context).changeIsFininsh();
                        });
                      },
                child: Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'cubit/cubit.dart';
import 'cubit/stats.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../component/components.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _pageController = PageController();
  int _currentPage = 0;
  String dropdownValue = "single";
  var globalkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddPostCubit(),
        child: BlocConsumer<AddPostCubit, AddPostStats>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  _currentPage == 0
                      ? IconButton(
                          onPressed: () {
                            if (globalkey.currentState!.validate()) {
                              print("done");
                              _pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            }
                          },
                          icon: const Icon(Icons.next_plan_outlined))
                      : Container()
                ],
                title: Row(
                  children: [
                    Icon(
                      Icons.post_add,
                      color: themAppColorIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "BROKER",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0)
                          // ignore: curly_braces_in_flow_control_structures
                          return Form(
                            key: globalkey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                          borderradius: 10,
                                          lable: "Title",
                                          lableColor: Colors.black,
                                          validate: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Title";
                                            }
                                          },
                                          controller:
                                              AddPostCubit.getobject(context)
                                                  .titlecontroller,
                                          type: TextInputType.name,
                                          prefx: Icons.home,
                                          textColor: Colors.black,
                                          hint: "Enter name of Property"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                          borderradius: 10,
                                          lable: "Price",
                                          lableColor: Colors.black,
                                          validate: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please Enter Price";
                                            }
                                          },
                                          controller:
                                              AddPostCubit.getobject(context)
                                                  .pricecontroller,
                                          type: TextInputType.number,
                                          prefx: Icons.attach_money_sharp,
                                          hint: "enter price of Property"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                          borderradius: 10,
                                          lable: "Space",
                                          lableColor: Colors.black,
                                          validate: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please Enter Space";
                                            }
                                          },
                                          controller:
                                              AddPostCubit.getobject(context)
                                                  .spacecontroller,
                                          type: TextInputType.number,
                                          prefx: Icons.space_dashboard,
                                          hint: "enter space of Property"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                          borderradius: 10,
                                          lable: "Rooms",
                                          lableColor: Colors.black,
                                          validate: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please Enter Rooms";
                                            }
                                          },
                                          controller:
                                              AddPostCubit.getobject(context)
                                                  .roomscontroller,
                                          type: TextInputType.number,
                                          prefx: Icons.door_front_door,
                                          hint: "enter number of rooms"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        items: <String>[
                                          'single',
                                          'double',
                                          'villa'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Flat type : $dropdownValue',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        else
                          // ignore: curly_braces_in_flow_control_structures
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      AddPostCubit.getobject(context)
                                          .getmainimage();
                                    },
                                    child: Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: AddPostCubit.getobject(context)
                                                  .mainimage ==
                                              null
                                          ? const Center(
                                              child: Text(
                                                  "please enter main image"),
                                            )
                                          : Image.file(
                                              AddPostCubit.getobject(context)
                                                  .mainimage!,
                                              fit: BoxFit.cover),
                                      width: 300,
                                      height: 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "Tap on main image to change of add",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    width: 380,
                                    height: 320,
                                    child: AddPostCubit.getobject(context)
                                                .imageindex !=
                                            0
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      1)
                                                    miniimagebuild(context, 1),
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      2)
                                                    miniimagebuild(context, 2),
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      3)
                                                    miniimagebuild(context, 3),
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      4)
                                                    miniimagebuild(context, 4),
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      5)
                                                    miniimagebuild(context, 5),
                                                  if (AddPostCubit.getobject(
                                                              context)
                                                          .imageindex >=
                                                      6)
                                                    miniimagebuild(context, 6),
                                                ],
                                              ))
                                            ],
                                          )
                                        : const Center(
                                            child: Text(
                                                "please images of Property"),
                                          ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: button("add images", () {
                                            if (AddPostCubit.getobject(context)
                                                    .imageindex <
                                                6) {
                                              AddPostCubit.getobject(context)
                                                  .getimages();
                                            } else {
                                              showToast(
                                                  text:
                                                      "You have exceeded the limit of possible images",
                                                  color: ToastColors.ERROR);
                                            }
                                          },
                                              h: 40,
                                              w: 35,
                                              color: Colors.white,
                                              colorborder: Colors.black,
                                              colorText: Colors.black,
                                              borderradius: 10,
                                              fontsize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: button("Remove all images",
                                              () {
                                            AddPostCubit.getobject(context)
                                                .removeallimages();
                                          },
                                              h: 40,
                                              w: 35,
                                              color: Colors.white,
                                              colorborder: Colors.black,
                                              colorText: Colors.black,
                                              borderradius: 10,
                                              fontsize: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                      },
                      itemCount: 2,
                      controller: _pageController,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: const ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                dotHeight: 10,
                                activeDotColor: Colors.black,
                                dotWidth: 10,
                                spacing: 5),
                          ),
                          Text("page ${_currentPage + 1} of 2")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: _currentPage == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        AddPostCubit.getobject(context).CreatePost(
                          title: AddPostCubit.getobject(context)
                              .titlecontroller
                              .text,
                          price: AddPostCubit.getobject(context)
                              .pricecontroller
                              .text,
                          mainImg:
                              AddPostCubit.getobject(context).mainimage as File,
                          images: AddPostCubit.getobject(context).images,
                          space: AddPostCubit.getobject(context)
                              .spacecontroller
                              .text,
                          numberOfRooms: AddPostCubit.getobject(context)
                              .roomscontroller
                              .text,
                          flatType: dropdownValue,
                        );
                      },
                      child: const Icon(Icons.upload),
                    )
                  : null,
            );
          },
          listener: (context, state) {
            if (state is CreatePostSuccessStats) {
              if (AddPostCubit.getobject(context).stateError == 'underReview') {
                showToast(
                    text:
                        "Success, your post is ${AddPostCubit.getobject(context).stateError!}",
                    color: ToastColors.SUCCESS);
                Navigator.of(context).pop();
              } else {
                showToast(
                    text: AddPostCubit.getobject(context).stateError!,
                    color: ToastColors.ERROR);
              }
            }
          },
        ));
  }

  Widget miniimagebuild(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 115,
      height: 160,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.file(AddPostCubit.getobject(context).images[index - 1],
              fit: BoxFit.cover),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            child: IconButton(
                onPressed: () {
                  AddPostCubit.getobject(context).removeimages(index: index);
                },
                icon: Icon(
                  Icons.close_sharp,
                  size: 15,
                  color: Colors.black,
                )),
          )
        ],
      ),
    );
  }
}



InkWell(
                                    onTap: () {
                                      AddPostCubit.getobject(context)
                                          .getmainimage();
                                    },
                                    child: Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: AddPostCubit.getobject(context)
                                                  .mainimage ==
                                              null
                                          ? const Center(
                                              child: Text(
                                                  "please enter main image"),
                                            )
                                          : Image.file(
                                              AddPostCubit.getobject(context)
                                                  .mainimage!,
                                              fit: BoxFit.cover),
                                      width: 300,
                                      height: 200,
                                    ),
                                  ),

*/
