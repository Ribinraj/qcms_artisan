import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/data/register_artisan.dart';

import 'package:qcms_artisan/presentation/bloc/fetch_departments_bloc/fetch_departments_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/register_artisan_bloc/register_artisan_bloc.dart';
import 'package:qcms_artisan/widgets/custom_loginloadingbutton.dart';
import 'package:qcms_artisan/widgets/custom_registertextfield.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:qcms_artisan/widgets/custom_searchdropdown.dart';
import 'package:qcms_artisan/widgets/custom_snackbar.dart';
import 'package:qcms_artisan/widgets/customloginbutton.dart';

class ScreenRegistrationpage extends StatefulWidget {
  const ScreenRegistrationpage({super.key});

  @override
  State<ScreenRegistrationpage> createState() => _ScreenRegistrationpageState();
}

class _ScreenRegistrationpageState extends State<ScreenRegistrationpage> {
  DropdownItem? selectedDivision;
  DropdownItem? selectedDepartment;
  // DropdownItem? selectedComplaintCategory;
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController mobilenumberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchDivisionBloc>().add(FetchDivisionInitialEvent());
    context.read<FetchDepartmentsBloc>().add(FetchDepartmentsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 27),
        ),
        title: Text(
          'Register Account',
          style: TextStyle(
            color: Appcolors.kwhitecolor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Appcolors.kprimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),

          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.place,
                    color: Appcolors.ksecondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  TextStyles.body(text: "Division"),
                ],
              ),
              ResponsiveSizedBox.height5,
              BlocBuilder<FetchDivisionBloc, FetchDivisionState>(
                builder: (context, state) {
                  if (state is FetchDivisionLoadingState) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E4F3),
                        border: Border(
                          bottom: BorderSide(
                            color: Appcolors.kprimaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      width: ResponsiveUtils.screenWidth,
                      padding: EdgeInsets.all(15),
                      child: SpinKitWave(
                        size: 15,
                        color: Appcolors.ksecondaryColor,
                      ),
                    );
                  } else if (state is FetchdivisionErrorState) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade600),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is FetchDivisonSuccessState) {
                    final divisionItems = state.divisions
                        .map(
                          (division) => DropdownItem(
                            id: division.cityId,
                            display: division.cityName,
                          ),
                        )
                        .toList();

                    return CustomSearchDropdown(
                      value: selectedDivision,
                      hintText: 'Please select division',
                      items: divisionItems,
                      enableSearch: true,
                      searchHintText: 'Search divisions...',
                      onChanged: (value) {
                        setState(() {
                          selectedDivision = value;
                        });
                        if (value != null) {
                          print('Selected Quarters ID: ${value.id}');
                          print('Selected Quarters Name: ${value.display}');
                        }
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              ResponsiveSizedBox.height30,
              Row(
                children: [
                  const Icon(
                    Icons.business,
                    color: Appcolors.ksecondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  TextStyles.body(text: "Department"),
                ],
              ),
              ResponsiveSizedBox.height5,
              BlocBuilder<FetchDepartmentsBloc, FetchDepartmentsState>(
                builder: (context, state) {
                  if (state is FetchDepartmentsLoadingState) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E4F3),
                        border: Border(
                          bottom: BorderSide(
                            color: Appcolors.kprimaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      width: ResponsiveUtils.screenWidth,
                      padding: EdgeInsets.all(15),
                      child: SpinKitWave(
                        size: 15,
                        color: Appcolors.ksecondaryColor,
                      ),
                    );
                  } else if (state is FetchDepartmentsErrorState) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade600),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is FetchDepartmentsSuccessState) {
                    final departmentItems = state.departments
                        .map(
                          (department) => DropdownItem(
                            id: department.departmentId,
                            display: department.departmentName,
                          ),
                        )
                        .toList();

                    return CustomSearchDropdown(
                      value: selectedDepartment,
                      hintText: "Please select department",
                      items: departmentItems,
                      enableSearch: true,
                      searchHintText: "Search departments...",
                      onChanged: (value) {
                        setState(() {
                          selectedDepartment = value;
                        });
                        if (value != null) {
                          print('Selected departmnt ID: ${value.id}');
                          print('Selected department Name: ${value.display}');
                        }
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),

              ResponsiveSizedBox.height30,

              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: Appcolors.ksecondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  TextStyles.body(text: "Artisan Name"),
                ],
              ),
              ResponsiveSizedBox.height5,
              CustomRegisterTextField(
                controller: usernamecontroller,
                hintText: 'Enter Your Name',
              ),
              ResponsiveSizedBox.height30,
              Row(
                children: [
                  const Icon(
                    Icons.phone_android,
                    color: Appcolors.ksecondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  TextStyles.body(text: "Artisan Mobile number"),
                ],
              ),
              ResponsiveSizedBox.height5,
              CustomRegisterTextField(
                controller: mobilenumberController,
                hintText: 'Enter Your Mobile number',
              ),
              ResponsiveSizedBox.height50,
              BlocConsumer<RegisterArtisanBloc, RegisterArtisanState>(
                listener: (context, state) {
                  if (state is RegisterArtisanSuccessState) {
                    CustomSnackbar.show(
                      context,
                      message: state.message,
                      type: SnackbarType.success,
                    );
                    CustomNavigation.pop(context);
                  } else if (state is RegisterArtisanErrorState) {
                    CustomSnackbar.show(
                      context,
                      message: state.message,
                      type: SnackbarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterArtisanLoadingState) {
                    return Customloginloadingbutton();
                  }
                  return Customloginbutton(
                    onPressed: () {
                      _handleRegistration();
                    },
                    text: 'Register Now',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  void _handleRegistration() {
    // Validation
    if (selectedDivision == null) {
      _showMessage('Please select a division');
      return;
    }

    if (usernamecontroller.text.trim().isEmpty) {
      _showMessage('Please enter occupant name');
      return;
    }

    if (mobilenumberController.text.trim().isEmpty) {
      _showMessage('Please enter occupant mobile number');
      return;
    }
    String mobile = mobilenumberController.text.trim();
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!mobileRegex.hasMatch(mobile)) {
      _showMessage('Please enter a valid 10-digit mobile number');
      return;
    }
    context.read<RegisterArtisanBloc>().add(
      RegisterButtonclickEvent(
        artisan: RegisterArtisanModel(
          divisionName: selectedDivision!.display,
          departmentName: selectedDepartment!.display,
          artisanName: usernamecontroller.text,
          artisanMobile: mobilenumberController.text,
        ),
      ),
    );
  }
}
