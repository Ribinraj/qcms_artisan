import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:qcms_artisan/presentation/screens/screen_complaints/screen_complaints.dart';
import 'package:qcms_artisan/presentation/screens/screen_dashboard/screen_dashboardpage.dart';
import 'package:qcms_artisan/presentation/screens/screen_mainpage/widgets/customnav.dart';
import 'package:qcms_artisan/presentation/screens/screen_profilepage/screen_profilepage.dart';
import 'package:qcms_artisan/presentation/screens/screen_solvedcomplaintspage/screen_solvedcomplaintspage.dart';

class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  final List<Widget> _pages = [
    ScreenDashboardpage(
    ),
    ScreenComplaintsPage(),
    ScreenSolvedcomplaintspage(),
    ScreenProfilepage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          //backgroundColor: const Color.fromARGB(255, 248, 232, 227),
          body: _pages[state.currentPageIndex],
          bottomNavigationBar: BottomNavigationWidget(
            onTap: (index) {
              context.read<BottomNavigationBloc>().add(
                NavigateToPageEvent(pageIndex: index),
              );
            },
          ),
        );
      },
    );
  }
}
