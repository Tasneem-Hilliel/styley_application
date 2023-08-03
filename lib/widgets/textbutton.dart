import 'package:flutter/material.dart';

import '../constants.dart';

Widget TextButtonbuilder( function,String text) {
 return TextButton(
      onPressed: function,
      child: Text(
       text,
        style: TextStyle(color: MainColor),
      ));
}
