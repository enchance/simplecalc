import 'package:isar/isar.dart';


part 'history.g.dart';

@collection
class History {
  Id id = Isar.autoIncrement;
  late String problem;
  late String solution;
  @Index(unique: true)
  late DateTime createdAt;
}