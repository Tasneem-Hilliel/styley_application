import 'dart:math';

import 'package:flutter/material.dart';

import 'package:chat_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/SharedPrefrences.dart';
import '../../widgets/defaultField.dart';
import '../../widgets/navigator.dart';
import '../appCubit/cubit.dart';
import '../appCubit/states.dart';
import 'AppLogin_Screen.dart';

class ProfileScreen extends StatelessWidget {
  // String? email;
  // String? name;
  //  ProfileScreen({
  //   Key? key,
  //   this.email,
  //   this.name,
  // }) : super(key: key);

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context).userModel;
          namecontroller.text = cubit!.name!;
          emailcontroller.text = cubit.email!;
          phonecontroller.text = cubit.phone!;

          return Scaffold(
              body: AppCubit.get(context).userModel != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 18, left: 10, right: 10),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // if (state is shopUpdateUserLoadingState)
                              // LinearProgressIndicator(),
                              defaultTextfield(
                                  namecontroller, "Name", Icons.person,
                                  (String? text) {
                                if (text == null) {
                                  return "Name can't be empty";
                                } else {
                                  return null;
                                }
                              }, TextInputType.name, false, () {}),
                              defaultTextfield(
                                  emailcontroller, "Email", Icons.email,
                                  (String? text) {
                                if (text == null) {
                                  return "Email can't be empty";
                                } else {
                                  return null;
                                }
                              }, TextInputType.emailAddress, false, () {}),
                              defaultTextfield(
                                  phonecontroller, "Phone Number", Icons.phone,
                                  (String? text) {
                                if (text == null) {
                                  return "Phone Number can't be empty";
                                } else {
                                  return null;
                                }
                              }, TextInputType.phone, false, () {}),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AppCubit.get(context)
                                              .updateUserProfile(
                                            namecontroller.text,
                                            emailcontroller.text,
                                            phonecontroller.text,
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Update",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: MainColor,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 50))),
                                  ElevatedButton(
                                      onPressed: () {
    
        return navigateWithReplacement(context, AppLoginScreen());
      
                                      },
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: MainColor,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 50))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                  : Center(
                      child: CircularProgressIndicator(),
                    ));
        });
  }
}
