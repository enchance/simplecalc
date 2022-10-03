import 'package:flutter/material.dart';
import 'package:isar/isar.dart';



class DBProvider with ChangeNotifier {
  Isar? isar;

  setIsar(Isar isar) {
    this.isar = isar;
  }
}