import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DoctorsDisplay extends StatelessWidget {
  final List<DoctorEntity> doctorsList;

  const DoctorsDisplay({Key? key, required this.doctorsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          print(doctorsList[index].profilePic);
          return ListTile(
            leading: CircleAvatar(
              radius: 21,
              child: CachedNetworkImage(
                imageUrl: doctorsList[index].profilePic,
                imageBuilder: (context, imageProvider) => Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.image)),
              ),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DoctorDetail(doctor: doctorsList[index])));
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
        itemCount: doctorsList.length);
  }
}
