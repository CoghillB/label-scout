// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_history_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanHistoryItemAdapter extends TypeAdapter<ScanHistoryItem> {
  @override
  final int typeId = 1;

  @override
  ScanHistoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanHistoryItem(
      barcode: fields[0] as String,
      productName: fields[1] as String,
      scanDate: fields[2] as DateTime,
      resultStatus: fields[3] as String,
      flaggedIngredients: (fields[4] as List).cast<String>(),
      brand: fields[5] as String?,
      imageUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScanHistoryItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.barcode)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.scanDate)
      ..writeByte(3)
      ..write(obj.resultStatus)
      ..writeByte(4)
      ..write(obj.flaggedIngredients)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanHistoryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
