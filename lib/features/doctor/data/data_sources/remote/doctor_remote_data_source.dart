import 'dart:convert';

import 'package:bima/core/error/exception.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors();
}

const String uriForDoctor =
    'https://5efdb0b9dd373900160b35e2.mockapi.io/contacts';

class DoctorRemoteDataSourceImpl extends DoctorRemoteDataSource {
  final http.Client client;

  DoctorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final response = await client.get(Uri.parse(uriForDoctor));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final doctors =
          List.from(result).map((e) => DoctorModel.fromJson(e)).toList();
      return doctors;
    } else {
      throw ServerException();
    }
  }
}
