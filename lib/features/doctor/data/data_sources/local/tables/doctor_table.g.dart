// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorTableAdapter extends TypeAdapter<DoctorTable> {
  @override
  final int typeId = 0;

  @override
  DoctorTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorTable(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      profilePic: fields[3] as String,
      specialization: fields[4] as String,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorTable obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.profilePic)
      ..writeByte(4)
      ..write(obj.specialization)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
