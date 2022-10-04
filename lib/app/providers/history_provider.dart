import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../collections/history.dart';
import './settings_provider.dart';



class HistoryProvider with ChangeNotifier {
  late SettingsProvider _settings;

  set settings(SettingsProvider prov) => _settings = prov;

  SettingsProvider get settings => _settings;

  _addHistory(History history) async {
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async {
      await isar.historys.put(history);
    });
  }

  // // _removeHistory(int id) => _data.removeWhere((element) => element.id == id);
  //
  // Future<List<History>> _fetchHistoryList() async {
  //   Isar isar = Isar.getInstance()!;
  //   return await isar.historys.where().sortByCreatedAtDesc().findAll();
  // }
  //
  // _clearHistory() async {
  //   Isar isar = Isar.getInstance()!;
  //   await isar.historys.where().idGreaterThan(0).deleteAll();
  // }

}