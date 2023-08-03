import 'package:chat_app/AppFolder/Screens/profile_Screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/main.dart';
// import 'package:chat_app/shop_cubit/cubit.dart';
// import 'package:chat_app/shop_cubit/states.dart';
// import 'package:chat_app/widgets/appBar.dart';
import 'package:chat_app/widgets/defaultField.dart';
// import 'package:chat_app/widgets/logOut.dart';
// import 'package:chat_app/widgets/profile.dart';

class settingsScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        
      },
      builder:(context, state) =>  Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            "My Styley",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: ProfileScreen(),
        // body: BlocConsumer<shopCubit, shopStates>(
        //     listener: (BuildContext context, state) {},
        //     builder: (BuildContext context, state) {
        //       var model = shopCubit.get(context);
        //       namecontroller.text = model.userModel!.data!.name!;
        //       emailcontroller.text = model.userModel!.data!.email!;
    
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: SingleChildScrollView(
        //           child: Column(
        //             children: [
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               profile(namecontroller.text, emailcontroller.text, context),
        //             ],
        //           ),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}
