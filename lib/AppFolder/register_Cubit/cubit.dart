import 'package:chat_app/AppFolder/register_Cubit/states.dart';
import 'package:chat_app/api/SharedPrefrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelApp/socialCreateuser.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());
  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid,
      );
      // emit(AppRegisterSuccessState());
    }).catchError((error) {
      emit(AppRegisterErrorState(error: error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uid,
  }) {
    emit(AppRegisterLoadingState());
    AppCreateUserModel? model = AppCreateUserModel(
        name: name,
        phone: phone,
        email: email,
        uid: uid,
        isEmailVerified: false,
        cover:
            "https://img.freepik.com/free-vector/abstract-black-texture-background-hexagon_206725-413.jpg?w=826&t=st=1678683705~exp=1678684305~hmac=a06e32232e7f31c78c62867e9bce2192cd8dbaeca22cc40b16350e6777a3a1d3",
        image:
            "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1678670398~exp=1678670998~hmac=e9b1633fcc4e5028707a44f428f5f8954b3b1b4c4e3cb39953fc0f68e5fff127",
        bio: "write your bio...");
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      SharedPref.setData(key: "uid", value: uid).then((value) {
        emit(AppCreateUserSuccessState(uid: uid));
      });
      print(uid);
    }).catchError((error) {
      print(error.toString());
      emit(AppCreateUserErrorState());
    });
  }

  IconData suffix = Icons.visibility;
  bool ispasssword = true;
  void changePassword() {
    ispasssword = !ispasssword;

    suffix = ispasssword ? Icons.visibility : Icons.visibility_off;
    emit(AppRegisterChangePasswordState());
  }
}
