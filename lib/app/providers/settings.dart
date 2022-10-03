import 'package:flutter/material.dart';


class BaseSettings {
  var appname = 'Simple Calculator';
}


class Settings extends BaseSettings with ChangeNotifier {
  var copyright = 2022;
}