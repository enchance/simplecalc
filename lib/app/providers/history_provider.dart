import 'package:SimpleCalc/app/collections/settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../collections/history.dart';
import './settings_provider.dart';



class HistoryProvider with ChangeNotifier {
  late SettingsProvider _settings;

  set settings(SettingsProvider prov) => _settings = prov;

  SettingsProvider get settings => _settings;

  // TODO: Populate datalist
  // TODO: Remove from the list
  // TODO: Read from the list

  addHistory(History history) async {
    try {
      Isar isar = Isar.getInstance()!;

      final settings = await isar.settings.where().nameEqualTo('hasHistoryData').findAll();
      print(settings);
      // final settings =
      //   Settings()
      //     ..name='hasHistoryData'..valueBool=true;
          // ..valueInt=null..valueStr=null;

      await isar.writeTxn(() async {
        await isar.historys.put(history);
        // await isar.settings.put(settings);
      });
    }
    catch(e) {
      print(e);
    }
  }

  // Future<List<History>> fetchHistoryList() async {
  //   Isar isar = Isar.getInstance()!;
  //   return await isar.historys.where().sortByCreatedAtDesc().findAll();
  // }

}