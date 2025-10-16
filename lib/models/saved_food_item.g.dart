// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_food_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedFoodItemAdapter extends TypeAdapter<SavedFoodItem> {
  @override
  final int typeId = 0;

  @override
  SavedFoodItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedFoodItem(
      barcode: fields[0] as String,
      productName: fields[1] as String,
      brand: fields[2] as String,
      savedDate: fields[3] as DateTime,
      status: fields[4] as String,
      category: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedFoodItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.barcode)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.savedDate)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedFoodItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
