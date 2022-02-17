import 'dart:convert';

import 'package:bima/core/error/exception.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  /// Calls the `BASE_URL` with `contacts` endpoint.
  /// Parse the value into List of type `DoctorModel`.
  /// Sorts the list based on the `rating` from highest to lowest
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<DoctorModel>> getAllDoctors();
}

class DoctorRemoteDataSourceImpl extends DoctorRemoteDataSource {
  final http.Client client;

  DoctorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final response =
        await client.get(Uri.parse(dotenv.get('BASE_URL') + '/contacts'));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final doctors =
          List.from(result).map((e) => DoctorModel.fromJson(e)).toList();
      doctors.sort((a, b) => b.rating.compareTo(a.rating));
      return doctors;
    } else {
      throw ServerException();
    }
  }

  void sortByRating() {}
}
