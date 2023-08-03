import 'package:chat_app/AppFolder/Screens/AppLogin_Screen.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/AppFolder/login_Cubit/states.dart';
import 'package:chat_app/AppFolder/onboardCubit/cubit.dart';
import 'package:chat_app/AppFolder/onboardCubit/states.dart';
import 'package:chat_app/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Api/SharedPrefrences.dart';
import '../../constants.dart';
import '../../widgets/onboardbuilder.dart';
import '../ModelApp/onboardmodel.dart';
import '../login_Cubit/cubit.dart';

// ignore: camel_case_types

class OnBoardScreen extends StatefulWidget {
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final _controller = PageController();
  void submit() {
    navigateTo(context, AppLoginScreen());
  }

  bool onLastPage = false;
  List<onboardModel> onboarding = [
    onboardModel("assets/images/virus.png", "Sanitary",
        'Help users who want to go shopping but are ill or worried about getting sick, as was the case during the Corona epidemic.'),
    onboardModel("assets/images/online.png", "Accessibility",
        'Helps customers in finding new items that suit their interests and preferences by allowing them to try on clothing before making a purchase.'),
    onboardModel("assets/images/others.png", "Transparency ",
        'Enabling consumers to express their genuine ideas through ratings, styley encourages transparency and increases customer trust ')
  , onboardModel("assets/images/help.jpg", "handily",
        'It relieves them of public transportation and traffic jam hassles and allows them to try on clothes from wherever they are.'),
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: submit,
            child: const Text(
              "Skip",
              style: TextStyle(color: Color.fromARGB(255, 17, 63, 19)),
            ),
          )
        ],
      ),
      body: Column(children: [
        // SizedBox(height: 20,),
        Expanded(
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                value == 3 ? onLastPage = true : onLastPage = false;
              });
            },
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            itemCount: onboarding.length,
            itemBuilder: (BuildContext context, int index) {
              return onboard_scr(onboarding[index]);
            },
          ),
        ),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Container(
            color: MainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: ExpandingDotsEffect(
                        dotColor: background,
                        activeDotColor: header,
                        dotWidth: 10,
                        // activeDotColor: Color(0xff8c7851)
                        dotHeight: 10),
                  ),
                  const Spacer(),
                  onLastPage == false
                      ? IconButton(
                          onPressed: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        )
                      : TextButton(
                          onPressed: submit,
                          child: const Text(
                            "Done",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
