import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/widgets/product_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/constants.dart';

import 'package:chat_app/widgets/navigator.dart';

class MenScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).menProducts;
        return Scaffold(
          body: ConditionalBuilder(
              condition: AppCubit.get(context).menProducts != null,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / 1.46,
                          children: List.generate(
                              AppCubit.get(context).menProducts!.length,
                              (index) {
                            return productBuilder(cubit![index], context);
                          }),
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}


