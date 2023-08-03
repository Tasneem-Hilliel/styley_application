import 'package:chat_app/AppFolder/Screens/AppLayout_scr.dart';
import 'package:chat_app/AppFolder/Screens/onBoard_screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
// import 'package:chat_app/screens/tabBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:chat_app/screens/shopLayout_scr.dart';
// import 'package:chat_app/screens/login_scr.dart';
// import 'package:chat_app/search_cubit/cubit.dart';
// import 'package:chat_app/shop_cubit/cubit.dart';
import 'AppFolder/Screens/AppLogin_Screen.dart';
import 'api/SharedPrefrences.dart';
import 'api/bloc_observer.dart';
import 'constants.dart';
// import 'Login_cubit/bloc_observer.dart';
// import 'screens/onboard_scr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await SharedPref.init();
  var onboard = SharedPref.getData(key: "onboarding") ?? '';
  print(onboard);
  uid = SharedPref.getData(key: "uid");
  print("From main screen $uid");

  Widget widget;
  if (onboard == null) {
    if (uid != null) {
      widget = layoutScreen();
    } else {
      widget = AppLoginScreen();
    }
  } else {
    widget = OnBoardScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              titleSpacing: 20),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MainColor,
              elevation: 30),
        ),
        home: startWidget,
      ),
    );
  }
}
