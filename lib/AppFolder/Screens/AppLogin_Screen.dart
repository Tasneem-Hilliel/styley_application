import 'package:chat_app/Api/SharedPrefrences.dart';
import 'package:chat_app/AppFolder/Screens/AppLayout_scr.dart';
import 'package:chat_app/AppFolder/Screens/profile_Screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../widgets/defaultField.dart';
import '../../widgets/navigator.dart';
import '../../widgets/textbutton.dart';
import '../login_Cubit/cubit.dart';
import '../login_Cubit/states.dart';
import 'AppRegister_Screen.dart';

class AppLoginScreen extends StatelessWidget {
  TextEditingController loginEmailController = TextEditingController();

  TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isChecked = false;

  void handleisChecked(bool? value) {
    isChecked = value!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            // AppCubit.get(context).getUser();
            // AppCubit.get(context).getAds();
            // AppCubit.get(context).getCartProducts();
            // AppCubit.get(context).getFavoriteProducts();

            // AppCubit.get(context).getProducts();

            navigateTo(context, layoutScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 68, 68, 68),
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Login now to continue from where you stopped.",
                              style: TextStyle(
                                  height: 1.4,
                                  color: Color.fromARGB(255, 134, 127, 127),
                                  fontSize: 16)),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextfield(
                              loginEmailController, "Email", Icons.email,
                              (String? value) {
                            if (value!.isEmpty) {
                              return "please enter your Email Address";
                            } else {
                              Null;
                            }
                          }, TextInputType.emailAddress, false, () {}),
                          defaultTextfield(
                              loginPasswordController,
                              "Password",
                              Icons.lock,
                              (String? value) {
                                if (value!.isEmpty) {
                                  return "please enter your password";
                                } else if (value.length <= 5) {
                                  return "password is too short";
                                }
                              },
                              TextInputType.text,
                              AppLoginCubit.get(context).ispasssword,
                              () {
                                // if (formkey.currentState!.validate()) {
                                // shopLoginCubit.get(context).userLogin(
                                //     email: emailController.text,
                                //     password: passwordController.text);}
                              },
                              suffix: AppLoginCubit.get(context).suffix,
                              suffixtap:
                                  AppLoginCubit.get(context).changePassword),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: handleisChecked,
                                    activeColor: MainColor,
                                  ),
                                  Text("Remember me")
                                ],
                              ),
                              TextButtonbuilder(() {}, "Forget password?")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ConditionalBuilder(
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                              builder: (context) {
                                return Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            AppLoginCubit.get(context)
                                                .userLogin(
                                                    email: loginEmailController
                                                        .text,
                                                    password:
                                                        loginPasswordController
                                                            .text);
                                          }
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: MainColor,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 130))),
                                  ],
                                );
                              },
                              condition: state is! AppLoginLoadingState,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButtonbuilder(() {
                                navigateTo(context, AppRegisterScreen());
                              }, "Register")
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
