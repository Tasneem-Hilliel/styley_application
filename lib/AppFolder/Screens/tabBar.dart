import 'package:chat_app/AppFolder/Screens/kidsScreen.dart';
import 'package:chat_app/AppFolder/Screens/search_screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import 'allCategories_screen.dart';
import 'menScreen.dart';
import 'womenScreen.dart';

// import '../AppFolder/Screens/menScreen.dart';
// import '../AppFolder/Screens/womenScreen.dart';
// import '../constants.dart';

class tabBarScreen extends StatefulWidget {
  @override
  _tabBarScreenState createState() => _tabBarScreenState();
}

class _tabBarScreenState extends State<tabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        
      },builder: (context, state) =>  DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Styley"),
            centerTitle: true,
            elevation: 1,
            // backgroundColor: MainColor,
            // toolbarHeight: kMinInteractiveDimension,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, searchScreen());
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.notifications),
              //   onPressed: () {},
              // ),
            ],
            bottom: TabBar(
              labelColor: Colors.black,
              indicator: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                color: MainColor,
                width: 2,
              ))),
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Women'),
                Tab(text: 'Men'),
                Tab(text: 'Kids'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
              AllCategoriesScreen(),
    
              WomenScreen(),
              MenScreen(),
              KidsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
