import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:hive/hive.dart';

abstract class DoctorLocalDataSource {
  Future<void> updateDoctor(DoctorTable doctorModel);
  Future<List<DoctorTable>> getDoctors();
  Future<void> insertOrUpdateAll(List<DoctorModel> doctors);
  Future<void> deleteAll();
}

class DoctorLocalDataSourceImpl extends DoctorLocalDataSource {
  @override
  Future<List<DoctorTable>> getDoctors() async {
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    List<DoctorTable> doctorData = box.toMap().values.toList();
    doctorData.sort((a, b) => b.rating.compareTo(a.rating));
    return doctorData;
  }

  @override
  Future<void> updateDoctor(DoctorTable doctorModel) async {
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    await box.putAt(doctorModel.id, doctorModel);
  }

  @override
  Future<void> insertOrUpdateAll(List<DoctorModel> doctors) async {
    final Map<String, DoctorTable> doctorMap = {
      for (var doctor in doctors)
        doctor.id.toString(): DoctorTable.fromModel(doctor)
    };
    final Box<DoctorTable> box = await Hive.openBox('doctor');
    print(doctorMap);
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
