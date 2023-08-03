import 'package:flutter/material.dart';

void navigateTo(BuildContext  context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void navigateWithReplacement(BuildContext context, widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}
