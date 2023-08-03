import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:chat_app/constants.dart';

class layoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context)
      ..getProducts()
      ..getAds()
      ..getUser()
      ..getCartProducts()
      // ..getCartProductsData()
      ..getFavoriteProducts();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              backgroundColor: Color.fromARGB(255, 250, 250, 250),
              body: SafeArea(child: cubit.bottomScreens[cubit.currentIndex]),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Colors.black.withOpacity(.1),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 8),
                    child: GNav(
                        rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 8,
                        activeColor: MainColor,
                        iconSize: 24,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        duration: Duration(milliseconds: 400),
                        tabBackgroundColor: Colors.white,
                        color: Colors.black,
                        tabs: [
                          GButton(
                            icon: Icons.home,
                            text: "Home",
                          ),
                          GButton(
                            icon: Icons.shopping_cart,
                            textSize: 5,
                            text: "Cart",
                          ),
                          GButton(
                            icon: Icons.favorite,
                            text: "Wish List",
                          ),
                          GButton(
                            icon: Icons.person,
                            text: "My Styley",
                          ),
                        ],
                        selectedIndex: cubit.currentIndex,
                        onTabChange: (index) {
                          cubit.changeNavBar(index);
                        }),
                  ),
                ),
              )

              // Container(
              //   width: double.infinity,
              //   child: GNav(
              //     gap: 10,
              //     onTabChange: (value) {
              //       cubit.changeNavBar(value);
              //     },
              //     tabs: [
              //       GButton(
              //         iconSize: 20,
              //         textSize: 10,
              //         icon: Icons.home,
              //         text: "Home",
              //       ),
              //       GButton(
              //         textSize: 10,
              //         iconSize: 20,
              //         icon: Icons.apps,
              //         text: "Categories",
              //       ),
              //       GButton(
              //         textSize: 10,
              //         iconSize: 20,
              //         icon: Icons.favorite,
              //         text: "Wish List",
              //       ),
              //       GButton(
              //         iconSize: 20,
              //         textSize: 10,
              //         icon: Icons.settings,
              //         text: "Settings",
              //       ),
              //     ],
              //     selectedIndex: cubit.currentIndex,
              //   ),
              // )

              //               BottomNavigationBar(
              //                   onTap: (value) {
              //                     cubit.changeNavBar(value);
              //                   },
              //                   currentIndex: cubit.currentIndex,
              //                   items: [
              //                     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              //                     BottomNavigationBarItem(
              //                         icon: Icon(Icons.apps), label: "Categories"),
              //                     BottomNavigationBarItem(
              //                         icon: Icon(Icons.favorite), label: "Wish List"),
              //                     BottomNavigationBarItem(
              //                         icon: Icon(Icons.settings), label: "Settings"),
              //                   ]
              //               ));
              // },
              );
        });
  }
}
