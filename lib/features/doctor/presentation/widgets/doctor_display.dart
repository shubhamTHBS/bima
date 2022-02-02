import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

class DoctorsDisplay extends StatelessWidget {
  final List<DoctorEntity> doctorsList;
  const DoctorsDisplay({Key? key, required this.doctorsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(doctorsList[index].profilePic),
            ),
            title: Text(doctorsList[index].firstName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorsList[index].specialization),
                Text(doctorsList[index].description)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
        itemCount: doctorsList.length);
  }
}
