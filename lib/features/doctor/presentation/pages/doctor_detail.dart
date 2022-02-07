import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetail extends StatefulWidget {
  final DoctorEntity doctor;

  const DoctorDetail({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.primaryColorDark,
      body: _body(),
    );
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _latNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.doctor.firstName;
    _latNameController.text = widget.doctor.lastName;
  }

  @override
  void dispose() {
    _firstNameController.clear();
    super.dispose();
  }

  SafeArea _body() {
    return SafeArea(
      child: Stack(
        // alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.accentColor,
                size: 25,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    widget.doctor.firstName + ' ' + widget.doctor.lastName,
                    style: const TextStyle(
                        fontFamily: Font.ROBOTO_CONDENSED_BOLD, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<DoctorBloc, DoctorState>(
                    listener: (context, state) {
                      if (state is DoctorsLoaded) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is DoctorLoading) {
                        return const LoadingWidget();
                      } else if (state is SaveState) {
                        return Button(
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                          height: 30,
                          title: 'Save Profile'.toUpperCase(),
                          onPressed: () {
                            BlocProvider.of<DoctorBloc>(context).add(
                                UpdateDoctorDetailEvent(
                                    doctorEntity: DoctorEntity(
                                        id: widget.doctor.id,
                                        description: widget.doctor.description,
                                        firstName: _firstNameController.text,
                                        lastName: _latNameController.text,
                                        profilePic: widget.doctor.profilePic,
                                        rating: widget.doctor.rating,
                                        specialization:
                                            widget.doctor.specialization)));
                          },
                          color: AppColor.primaryGreen,
                          borderRadius: 6,
                          fontSize: 14,
                          font: Font.ROBOTO_CONDENSED_BOLD,
                          textColor: Colors.white.withOpacity(0.6),
                        );
                      }
                      return Button(
                        padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                        height: 30,
                        title: 'Edit Profile'.toUpperCase(),
                        onPressed: () {
                          BlocProvider.of<DoctorBloc>(context).add(IsEdit());
                        },
                        color: AppColor.primaryGreen,
                        borderRadius: 6,
                        fontSize: 14,
                        font: Font.ROBOTO_CONDENSED_BOLD,
                        textColor: Colors.white.withOpacity(0.6),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(12.5),
                        child: Text(
                          'Personal Details'.toUpperCase(),
                          style: const TextStyle(
                              fontFamily: Font.ROBOTO_CONDENSED_BOLD,
                              fontSize: 20),
                        ),
                      ))),
                  BlocBuilder<DoctorBloc, DoctorState>(
                    builder: (context, state) {
                      return Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'First Name'.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily:
                                                Font.ROBOTO_CONDENSED_BOLD,
                                          ),
                                        ),
                                        TextFormField(
                                          readOnly: state is DoctorInitial,
                                          controller: _firstNameController,
                                          // onChanged: (value) =>
                                          //     _firstNameController.text = value,
                                          decoration: const InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 4, 0, 4),
                                              border: InputBorder.none),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Last Name'.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily:
                                                Font.ROBOTO_CONDENSED_BOLD,
                                          ),
                                        ),
                                        TextFormField(
                                          readOnly: state is DoctorInitial,
                                          controller: _latNameController,
                                          // onChanged: (value) =>
                                          //     _latNameController.text = value,
                                          decoration: const InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 4, 0, 4),
                                              border: InputBorder.none),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contact Number'.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily:
                                                Font.ROBOTO_CONDENSED_BOLD,
                                          ),
                                        ),
                                        TextFormField(
                                          readOnly: true,
                                          // initialValue:
                                          //     widget.doctor.primaryContactNo,
                                          decoration: const InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 4, 0, 4),
                                              border: InputBorder.none),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 22.5),
            child: Align(
              alignment: Alignment.topCenter,
              // child: CircleAvatar(
              //   backgroundColor: Colors.white,
              //   radius: 45,
              //   child: ClipOval(
              //     child: Image.asset(
              //       'assets/images/bima-logo.png',
              //       height: 150,
              //       width: 150,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45.0,
                child: CachedNetworkImage(
                  imageUrl: widget.doctor.profilePic,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 84.0,
                    height: 84.0,
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
            ),
          ),
        ],
      ),
    );
  }
}
