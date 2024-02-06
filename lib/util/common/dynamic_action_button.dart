import 'package:flutter/material.dart';

Widget dynamicActionButton(String txt, Function() action) {
  return ElevatedButton(onPressed: action, child: Text(txt));
}
