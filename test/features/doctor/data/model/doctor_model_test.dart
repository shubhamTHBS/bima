import 'dart:convert';

import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  final tDoctorModel = DoctorModel(
      id: 1,
      firstName: 'Amitabh',
      lastName: 'Bachchan',
      profilePic:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Indian_actor_Amitabh_Bachchan.jpg/440px-Indian_actor_Amitabh_Bachchan.jpg',
      favorite: false,
      primaryContactNo: '+919793380800',
      rating: '3.5',
      emailAddress: 'ab@email.com',
      qualification:
          'BSc Medical Sciences (2006), MBChB (2010), LLB Bachelor of Laws (2015)',
      description:
          'Meet Dr. Amitabh, our Chief Medical Officer. Dr. Amitabh completed his medical training at University of India Medical School and has practiced medicine for over 8 years. His passion is to reach out to every Indiaian with quality medical information and care and this is why he loves telemedicine. He enjoys reading, watching movies and listening to music.',
      specialization: 'General Practice',
      languagesKnown: 'English, Hindi, Kannada');

  test('should be a subclass of Doctor entity', () async {
    // Assert
    expect(tDoctorModel, isA<DoctorEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON case is doctor', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = json
          .decode(fixture('fixture_doctor_data.json')) as Map<String, dynamic>;
      // Act
      final DoctorModel result = DoctorModel.fromJson(jsonMap);
      // Assert
      expect(result, tDoctorModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // Act
      final Map<String, dynamic> result = tDoctorModel.toJson();
      // Assert
      final expectedMap = {
        'id': 1,
        'first_name': 'Amitabh',
        'last_name': 'Bachchan',
        'profile_pic':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Indian_actor_Amitabh_Bachchan.jpg/440px-Indian_actor_Amitabh_Bachchan.jpg',
        'favorite': false,
        'primary_contact_no': '+919793380800',
        'rating': '3.5',
        'email_address': 'ab@email.com',
        'qualification':
            'BSc Medical Sciences (2006), MBChB (2010), LLB Bachelor of Laws (2015)',
        'description':
            'Meet Dr. Amitabh, our Chief Medical Officer. Dr. Amitabh completed his medical training at University of India Medical School and has practiced medicine for over 8 years. His passion is to reach out to every Indiaian with quality medical information and care and this is why he loves telemedicine. He enjoys reading, watching movies and listening to music.',
        'specialization': 'General Practice',
        'languagesKnown': 'English, Hindi, Kannada'
      };
      expect(result, expectedMap);
    });
  });
}
