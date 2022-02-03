import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
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
              backgroundImage:
                  NetworkImage(doctorsList[index].profilePic.toString()),
            ),
            title: Text(
              doctorsList[index].firstName + ' ' + doctorsList[index].lastName,
              style: const TextStyle(
                color: AppColor.primaryColorDark,
                fontFamily: Font.ROBOTO_CONDENSED_BOLD,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    doctorsList[index].specialization.toUpperCase(),
                    style: const TextStyle(
                      color: AppColor.primaryColorDark,
                      fontFamily: Font.ROBOTO_CONDENSED_REGULAR,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    doctorsList[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: Font.ROBOTO,
                    ),
                  ),
                )
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppColor.primaryColor,
              ),
              onPressed: () {},
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
        itemCount: doctorsList.length);
  }
}
