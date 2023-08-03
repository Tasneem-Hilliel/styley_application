import 'package:flutter/material.dart';

import '../AppFolder/ModelApp/onboardmodel.dart';
import '../constants.dart';

Widget onboard_scr(onboardModel model) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Column(children: [
        SizedBox(height: 300, child: Image.asset(model.image)),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            model.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 18, height: 1.5),
          ),
        )
      ]),
    ),
  );
}
