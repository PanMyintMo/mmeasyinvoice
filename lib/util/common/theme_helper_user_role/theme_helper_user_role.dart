import 'package:flutter/material.dart';

class ThemeHelperUserRole {
  InputDecoration textInputDecoration([
    String lableText = "",
    String hintText = "",
    IconData? iconData,
  ]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
            
              child: Icon(iconData),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 50),
      
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(

      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(20, 20)),
      backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
      foregroundColor: MaterialStateProperty.all(Colors.white),
   
    );
  }
}

