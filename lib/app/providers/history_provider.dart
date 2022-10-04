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
    // Save to db
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async {
      await isar.historys.put(history);
    });
  }

  removeHistory(int id) async {
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async => await isar.historys.delete(id));
  }

  Future<List<History>> fetchHistoryList() async {
    Isar isar = Isar.getInstance()!;
    return await isar.historys.where().sortByCreatedAtDesc().findAll();
  }

  clearHistory() async {
    Isar isar = Isar.getInstance()!;
    await isar.writeTxn(() async {
      await isar.historys.where().idGreaterThan(0).deleteAll();
    });
  }

}