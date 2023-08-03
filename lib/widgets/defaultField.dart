import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

Widget defaultTextfield(
        TextEditingController controller,
        String txt,
        IconData iconData,
        function,
        TextInputType textInputType,
        ispassword,
        ontap,
        {IconData? suffix,
        suffixtap,
        onsubmitted,
        double borderRadius = 10}) =>
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        onFieldSubmitted: onsubmitted,
        obscureText: ispassword,
        validator: function,
        onTap: ontap,
        keyboardType: textInputType,
        controller: controller,
        // maxLines: 2,
        // minLines: 1,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
            prefixIconColor: MainColor,
            suffixIcon: IconButton(
              icon: Icon(suffix),
              onPressed: suffixtap,
            ),
            suffixIconColor: MainColor,
            filled: true,
            fillColor: Colors.grey[100],
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.white),
            ),
            border: InputBorder.none,
            hintText: txt,
            prefixIcon: Icon(iconData)),
      ),
    );
