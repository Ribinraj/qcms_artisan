// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qcms_artisan/core/colors.dart';
// import 'package:qcms_artisan/core/responsiveutils.dart';
// import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';

// class BottomNavigationWidget extends StatelessWidget {
//   final void Function(int)? onTap;
//   const BottomNavigationWidget({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//       builder: (context, state) {
//         return BottomNavigationBar(
//           currentIndex: state.currentPageIndex,
//           onTap: onTap,

//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Appcolors.kprimarytextColor,
//           selectedItemColor: Appcolors.kwhitecolor,
//           unselectedItemColor: const Color.fromARGB(255, 245, 146, 113),
//           // selectedIconTheme: const IconThemeData(color: Appcolors.kblackcolor),
//           unselectedIconTheme: IconThemeData(
//             color: const Color.fromARGB(255, 245, 146, 113),
//           ),
//           selectedLabelStyle: const TextStyle(fontSize: 10),
//           unselectedLabelStyle: const TextStyle(fontSize: 10),
//           items: [
//             BottomNavigationBarItem(
//               activeIcon: Icon(
//                 Icons.home,
//                 color: Appcolors.kwhitecolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               icon: Icon(Icons.home_outlined, size: ResponsiveUtils.wp(7)),
//               label: "Dashboard",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add, size: ResponsiveUtils.wp(7)),
//               activeIcon: Icon(
//                 Icons.add_circle_outline,
//                 color: Appcolors.kwhitecolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               label: "complaints",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_rounded, size: ResponsiveUtils.wp(7)),
//               activeIcon: Icon(
//                 Icons.list_rounded,
//                 color: Appcolors.kwhitecolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               label: "Solved",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_2_outlined, size: ResponsiveUtils.wp(7)),
//               activeIcon: Icon(
//                 Icons.person,
//                 color: Appcolors.kwhitecolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               label: "Profile",
//             ),

//           ],
//         );
//       },
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';

class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  const BottomNavigationWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentPageIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Appcolors.kprimarytextColor,
          selectedItemColor: Appcolors.kwhitecolor,
          unselectedItemColor: Appcolors.kTertiaryColor,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/remove_13962958.png',
                  color: Appcolors.kwhitecolor, // active color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/remove_13962958.png',
                  color: Appcolors.kTertiaryColor, // inactive color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              label:  "bottombar_dashboard".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/exam_3074131.png',
                  color: Appcolors.kwhitecolor, // active color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/exam_3074131.png',
                  color: Appcolors.kTertiaryColor, // inactive color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              label:"bottombar_complaints".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/solution_10161169.png',
                  color: Appcolors.kwhitecolor, // active color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/solution_10161169.png',
                  color: Appcolors.kTertiaryColor, // inactive color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              label: "bottombar_completed".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/people_13916215.png',
                  color: Appcolors.kwhitecolor, // active color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Image.asset(
                  'assets/images/people_13916215.png',
                  color: Appcolors.kTertiaryColor, // inactive color
                  width: ResponsiveUtils.wp(6),
                  height: ResponsiveUtils.wp(6),
                ),
              ),
              label:   "bottombar_profile".tr(),
            ),
          ],
        );
      },
    );
  }
}
