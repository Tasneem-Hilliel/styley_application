import 'package:chat_app/AppFolder/Screens/AppLayout_scr.dart';
import 'package:chat_app/widgets/navigator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/SharedPrefrences.dart';
import '../../constants.dart';
import '../../widgets/defaultField.dart';
import '../register_Cubit/cubit.dart';
import '../register_Cubit/states.dart';

class AppRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
          listener: (context, state) {
        if (state is AppCreateUserSuccessState) {
          //   SharedPref.setData(key: "uid", value: state.uid.toString()).then((value) {
          //     uid = state.uid;
          navigateWithReplacement(context, layoutScreen());
          // });

          // navigateWithReplacement(context, SocialLayout());
        }
      }, builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: form_key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("Start by creating an accounnt",
                        style: TextStyle(
                            color: Color.fromARGB(255, 68, 68, 68),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 35,
                    ),
                    defaultTextfield(nameController, "Name", Icons.person,
                        (String? text) {
                      if (text!.isEmpty) {
                        return "Name can't be empty";
                      } else {
                        return null;
                      }
                    }, TextInputType.name, false, () {}),
                    defaultTextfield(emailController, "Email", Icons.email,
                        (String? text) {
                      if (text!.isEmpty) {
                        return "Email can't be empty";
                      } else {
                        return null;
                      }
                    }, TextInputType.emailAddress, false, () {}),
                    defaultTextfield(
                        phoneController, "Phone number", Icons.phone,
                        (String? text) {
                      if (text!.isEmpty) {
                        return "Phone can't be empty";
                      } else {
                        return null;
                      }
                    }, TextInputType.phone, false, () {}),
                    defaultTextfield(
                        passwordController,
                        "Password",
                        Icons.lock,
                        (String? text) {
                          if (text!.isEmpty) {
                            return "Password can't be empty";
                          } else {
                            return null;
                          }
                        },
                        TextInputType.text,
                        AppRegisterCubit.get(context).ispasssword,
                        () {
                          AppRegisterCubit.get(context).changePassword();
                        },
                        suffix: AppRegisterCubit.get(context).suffix),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        builder: (context) => ElevatedButton(
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                AppRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MainColor,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 160))),
                        condition: state is! AppRegisterLoadingState,
                        fallback: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
