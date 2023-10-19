import 'package:hive/hive.dart';

part 'user_data_combined.g.dart';

@HiveType(typeId: 1)
class UserDataCombined {
  @HiveField(0)
  String name;

  @HiveField(1)
  double height;

  @HiveField(2)
  List<double> imcList;

  UserDataCombined(this.name, this.height, this.imcList);
}
