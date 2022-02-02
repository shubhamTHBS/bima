import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:hive/hive.dart';

abstract class DoctorLocalDataSource {
  Future<void> saveDoctor(DoctorTable movieTable);
  Future<List<DoctorModel>> getDoctors();
  Future<void> insertOrUpdateAll(List<DoctorModel> doctors);
  Future<void> deleteAll();
}

class DoctorLocalDataSourceImpl extends DoctorLocalDataSource {
  @override
  Future<List<DoctorModel>> getDoctors() async {
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    final List<DoctorTable> doctorData = box.toMap().values.toList();
    return doctorData.map(DoctorTable.toModel).toList();
  }

  @override
  Future<void> saveDoctor(DoctorTable movieTable) {
    // TODO: implement saveDoctor
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdateAll(List<DoctorModel> doctors) async {
    final Map<String, DoctorTable> doctorMap = {
      for (var doctor in doctors)
        doctor.id.toString(): DoctorTable.fromModel(doctor)
    };
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    await box.putAll(doctorMap);
  }

  @override
  Future<void> deleteAll() async {
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    final List<String> boxKeys = await keys;
    await box.deleteAll(boxKeys);
  }

  Future<List<String>> get keys async {
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    final List<String> result = box.keys.map((k) => k.toString()).toList();
    return result;
  }
}
