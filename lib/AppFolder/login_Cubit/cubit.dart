import 'package:chat_app/AppFolder/login_Cubit/states.dart';
import 'package:chat_app/api/SharedPrefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/navigator.dart';
import '../Screens/AppLogin_Screen.dart';
import '../appCubit/states.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());
  static AppLoginCubit get(context) => BlocProvider.of(context);
  // AppLoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      SharedPref.setData(key: "uid", value: value.user!.uid).then((value) {
        
      emit(AppLoginSuccessState());

      });
    }).catchError((error) {
      print("from login cubit $error");
      emit(AppLoginErrorState(error: error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool ispasssword = true;
  void changePassword() {
    ispasssword = !ispasssword;

    suffix = ispasssword ? Icons.visibility : Icons.visibility_off;
    emit(AppChangePasswordState());
  }



}
