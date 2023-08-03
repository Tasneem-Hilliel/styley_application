import 'dart:io';

import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/ModelApp/commentModel.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api/SharedPrefrences.dart';
import '../../widgets/navigator.dart';
import '../ModelApp/UserModel.dart';
import '../Screens/AppLogin_Screen.dart';
import '../Screens/cart_scr.dart';
import '../Screens/favourite_scr.dart';
import '../Screens/settings_scr.dart';
import '../Screens/tabBar.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    // productsScreen(),
    tabBarScreen(),
    CartScreen(),
    favouriteScreen(),
    settingsScreen(),
  ];

  int currentIndex = 0;
  void changeNavBar(index) {
    // currentIndex = index;
    if (currentIndex == 0) {
      currentIndex = index;
      getAds();
      getProducts();
    } else if (currentIndex == 2) {
      currentIndex = index;

      getFavoriteProducts();
    } else if (currentIndex == 3) {
      currentIndex = index;

      getUser();
    } else {
      currentIndex = index;
    }
    emit(shopChangeBottomNavBarState());
  }

  List<CategoryModel>? kidsProducts;
  List<CategoryModel>? womenProducts;
  List<CategoryModel>? menProducts;
  List<CategoryModel>? allProducts;

  CategoryModel? model;
  getProducts() {
    kidsProducts = [];
    allProducts = [];
    menProducts = [];
    womenProducts = [];
    emit(GetProductsLoadingState());
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("products")
            .doc(element.id)
            .update({'pid': element.id});

        model = CategoryModel.fromJson(element.data());

        allProducts!.add(model!);

        if (model!.productCategory == 'men') {
          menProducts!.add(model!);
        } else if (model!.productCategory == 'women') {
          womenProducts!.add(model!);
        } else if (model!.productCategory == 'kids') {
          kidsProducts!.add(model!);
        }
      });
      emit(GetProductsSuccessState());
    }).catchError((error) {
      print("============${error} ===================");
      emit(GetProductsErrorState(error));
    });
  }

  List<dynamic>? inFavourite = [];
  void changeFavouriteProducts(CategoryModel model) {
    emit(AddtoFavouriteLoadingStates());
    // inFavourite = [];
    FirebaseFirestore.instance
        .collection("products")
        .doc(model.pid)
        .get()
        .then((value) {
      inFavourite = value.data()!['inFavourite'];

      print(model.pid);

      if (inFavourite!.contains(uid)) {
        inFavourite!.removeAt(inFavourite!.indexOf(uid!));
        print("deleted");
      } else {
        inFavourite!.add(uid!);
        print("add");
      }
      FirebaseFirestore.instance
          .collection("products")
          .doc(model.pid)
          .update({'inFavourite': inFavourite!}).then((value) {
        FirebaseFirestore.instance
            .collection("products")
            .doc(model.pid)
            .snapshots()
            .listen((event) {
          model.isFavourite = event.data()!['inFavourite'];
          print("${model.isFavourite} modelllllllllllll");
        });

        getFavoriteProducts();

        // getProducts();
        emit(AddtoFavouriteSuccessStates());
      }).catchError((error) {
        print(error);

        emit(AddtoFavouriteErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(AddtoFavouriteErrorStates());
    });
  }

  List<CategoryModel>? favouritesList;
  getFavoriteProducts() {
    emit(GetFavouriteDataLoadingStates());
    favouritesList = [];
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        model = CategoryModel.fromJson(element.data());
        // print(element.data());

        // print(model!.isFavourite);

        if (model!.isFavourite!.contains(uid)) {
          favouritesList!.add(model!);
        }
      });
      emit(GetFavouriteDataSuccessStates());

      // print("${favouritesList} ------------- fav list");
    }).catchError((error) {
      print("============${error}");
      emit(GetFavouriteDataErrorStates());
    });
  }

  List<dynamic>? inCart = [];

  void changeCartProducts(CategoryModel model) {
    emit(AddToCartLoadingStates());
    // inFavourite = [];
    FirebaseFirestore.instance
        .collection("products")
        .doc(model.pid)
        .get()
        .then((value) {
      inCart = value.data()!['inCart'];

      print(model.pid);

      if (inCart!.contains(uid)) {
        inCart!.removeAt(inCart!.indexOf(uid!));
        print("deleted");
      } else {
        inCart!.add(uid!);
        print("add");

        // print(inFavourite);
      }
      FirebaseFirestore.instance
          .collection("products")
          .doc(model.pid)
          .update({'inCart': inCart!}).then((value) {
        FirebaseFirestore.instance
            .collection("products")
            .doc(model.pid)
            .snapshots()
            .listen((event) {
          model.inCart = event.data()!['inCart'];
          print("${model.inCart} modelllllllllllll");
        });

        getCartProducts();

        // getProducts();
        emit(AddToCartSuccessStates());
      }).catchError((error) {
        print(error);

        emit(AddToCartErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(AddToCartErrorStates());
    });
  }

  List<CategoryModel>? CartList;
  double total = 0;
  getCartProducts() {
    emit(GetCartDataLoadingStates());
    total = 0;
    CartList = [];
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        model = CategoryModel.fromJson(element.data());

        if (model!.inCart!.contains(uid)) {
          CartList!.add(model!);
          total += model!.price;
        }
      });
      emit(GetCartDataSuccessStates());

      // print("${favouritesList} ------------- fav list");
    }).catchError((error) {
      print("============${error}");
      emit(GetCartDataErrorStates());
    });
  }

  CreateUserModel? userModel;
  getUser() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      // print("from social cubit///// ${value.data()}");
      userModel = CreateUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates());
    });
  }

  // addToCart(
  //   itemName,
  //   itemImage,
  //   itemDescription,
  //   itemPrice,
  // ) {
  //   CategoryModel pickedItem = CategoryModel(
  //       delivered: '12:00',
  //       name: itemName,
  //       description: itemDescription,
  //       images: itemImage,
  //       price: itemPrice);

  //   FirebaseFirestore.instance
  //       .collection('users-cart-items')
  //       .doc(uid)
  //       .collection('items')
  //       .doc()
  //       .set(pickedItem.toJson())
  //       .then((value) {
  //     // print(pickedItem.name);
  //     getCartProductsData();
  //     emit(AddToCartSuccessStates());
  //   }).catchError((error) {
  //     print("Error when added to cart $error");
  //     emit(AddToCartErrorStates());
  //   });
  // }

  // List<CategoryModel>? cartItems;
  // getCartProductsData() {
  //   cartItems = [];
  //   emit(GetCartDataLoadingStates());
  //   FirebaseFirestore.instance
  //       .collection('users-cart-items')
  //       .doc(uid)
  //       .collection('items')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       cartItems!.add(CategoryModel.fromJson(element.data()));
  //     });
  //     // print("cart success////// ${cartItems![0].name}");
  //     emit(GetCartDataSuccessStates());
  //   }).catchError((error) {
  //     print("From cart error ${error}");
  //     emit(GetCartDataErrorStates());
  //   });
  // }

  List<dynamic> AdsList = [];
  getAds() {
    AdsList = [];
    emit(GetAdsLoadingStates());
    FirebaseFirestore.instance.collection("advertisements").get().then((value) {
      value.docs[0].data()['ads'].forEach((element) {
        AdsList.add(element);
      });

      emit(GetAdsSuccessStates());
    }).catchError((error) {
      print("ads Error $error");
    });
  }

  updateUserProfile(name, email, phone) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'name': name, 'email': email, "phone": phone}).then((value) {
      getUser();
      emit(UpdateUserProfileSuccessStates());
    }).catchError((error) {
      print(error);
      emit(UpdateUserProfileErrorStates());
    });
  }

  List<CategoryModel>? searchResult;

  searchData(value) {
    emit(SearchResultLoadingStates());
    searchResult = [];

    allProducts!.forEach((element) {
      if (element.name!.contains(value)) {
        print(element.name);
        searchResult!.add(element);
      }
    });

    if (value == null) {
      searchResult = [];
    }
    // FirebaseFirestore.instance
    //     .collection('products')
    //     .where('name', isGreaterThanOrEqualTo: value)
    //     .where('name', isLessThan: value + 'z')
    //     .get()
    // .then((value) {
    // value.docs.forEach((doc) {
    //   model = CategoryModel.fromJson(doc.data());
    //   searchResult!.add(model!);
    // });
    // searchResult!.forEach(
    //   (element) => print(element.name),
    // );
    // print(searchResult!);
    emit(SearchResultSuccessStates());
    // }).catchError((error) {
    //   print('Error searching documents: $error');
    //   emit(SearchResultErrorStates());
    // });
  }

  File? profileImage;
  String? imageURL;
  ImagePicker picker = ImagePicker();

  Future<void> PickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      imageURL = Uri.file(profileImage!.path).toString();
      print(imageURL);
      emit(PickedImageSuccessStates());
    } else {
      print("no image selected");
      emit(PickedImageErrorStates());
    }
  }

  bool isFinish = false;
  bool isLoading = false;
  changeIsLoading() {
    isLoading = !isLoading;
    emit(IsLoadingStates());
  }

  changeIsFininsh() {
    isFinish = !isFinish;
    emit(IsFinishStates());
  }

  logOut(context) {
    SharedPref.removeData(key: "uid").then((value) {
      return navigateWithReplacement(context, AppLoginScreen());
    });
    emit(LogOutSuccessStates());
  }

  updateRating(rating, id) {
    FirebaseFirestore.instance
        .collection("products")
        .doc(id)
        .update({'rate': rating}).then((value) {
      getProducts();
      emit(UpdateRatingSuccessStates());
    }).catchError((error) {
      print(error);
      emit(UpdateRatingErrorStates());
    });
  }

  List<CommentModel>? commentsList = [];

  MakeComment(pid, delivered, comment) {
    emit(CommentLoadingStates());
    FirebaseFirestore.instance
        .collection("comments")
        .doc(pid)
        .collection('Comments_list')
        .add({
      "name": userModel!.name,
      "delivered": delivered,
      "comment": comment,
    }).then((value) {
      // print("Frommmmm make comment ${value}");
      emit(CommentSuccessStates());
    }).catchError((error) {
      print(error);
      emit(CommentErrorStates());
    });
  }

  getComment(pid) {
    emit(GetCommentLoadingStates());
    commentsList = [];
    FirebaseFirestore.instance
        .collection("comments")
        .doc(pid)
        .collection("Comments_list")
        .get()
        .then((value) {
      value.docs.forEach(
        (element) {
          commentsList!.add(CommentModel.fromJson(element.data()));
        },
      );

      print(commentsList![0].name);
      emit(GetCommentSuccessStates());
    }).catchError((error) {
      print(error);
      emit(GetCommentErrorStates());
    });
  }

  bool flag = false;
  changeFlag() {
    flag = !flag;
    emit(ChangeFlagState());
  }
}
