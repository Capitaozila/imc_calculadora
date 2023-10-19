// user_data_combined.g.dart
// Este arquivo será gerado automaticamente pelo Hive.

part of 'user_data_combined.dart';

class UserDataCombinedAdapter extends TypeAdapter<UserDataCombined> {
  @override
  final int typeId = 1;

  @override
  UserDataCombined read(BinaryReader reader) {
    return UserDataCombined(
      reader.readString(),
      reader.readDouble(),
      reader.readList().cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserDataCombined obj) {
    writer
      ..writeString(obj.name)
      ..writeDouble(obj.height)
      ..writeList(obj.imcList);
  }
}
