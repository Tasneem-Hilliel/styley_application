import 'package:chat_app/AppFolder/Screens/item_screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/divider.dart';
import '../../widgets/searchBuilder.dart';

class searchScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context).searchResult;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: MainColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 9.0),
                        //   child: Container(
                        //     width: 280,
                        //     height: 2,
                        //     color: Colors.amber,
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: SizedBox(
                            width: 320,
                            height: 45,
                            child: TextFormField(
                              onFieldSubmitted: (value) {},
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "search musn't be empty";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                AppCubit.get(context).searchData(value);
                              },
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              controller: controller,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                  prefixIconColor: MainColor,
                                  suffixIconColor: MainColor,
                                  filled: true,
                                  fillColor: Color.fromARGB(85, 231, 226, 226),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: InputBorder.none,
                                  hintText: ("Search..."),
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  cubit == null
                      ? Container()
                      : Center(
                          child: SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: cubit.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        itemScreen(AppCubit.get(context)
                                            .searchResult![index]));
                                  },
                                  child: ListTile(
                                    title: Text("${cubit[index].name}"),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        });
  }
}
