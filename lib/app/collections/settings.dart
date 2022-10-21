import 'package:isar/isar.dart';


part 'settings.g.dart';

@collection
class Settings {
  Id id = Isar.autoIncrement;
  @Index(unique: true, caseSensitive: false)
  late String name;
  int? valueInt;
  String? valueStr;
  bool valueBool = false;
}