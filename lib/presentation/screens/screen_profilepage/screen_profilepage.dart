import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/domain/controllers/notificationcontroller.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/language_cubit/language_cubit.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfilepage extends StatefulWidget {
  const ScreenProfilepage({super.key});

  @override
  State<ScreenProfilepage> createState() => _ScreenSettingsPageState();
}

class _ScreenSettingsPageState extends State<ScreenProfilepage> {
  String selectedLanguage = 'English';
  bool isLanguageExpanded = false;
  bool isPushNotificationsEnabled = true;

  final Map<String, Map<String, String>> languages = {
    'English': {'code': 'en', 'display': 'English'},
    'Hindi': {'code': 'hi', 'display': 'हिन्दी'},
    'Kannada': {'code': 'kn', 'display': 'ಕನ್ನಡ'},
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedLanguage();
  }

  // Load the saved language from SharedPreferences and current context
  void _loadSavedLanguage() {
    try {
      // Get current app locale
      final currentLocale = context.locale;

      // Find the matching language key based on locale code
      String languageKey = 'English'; // default

      for (var entry in languages.entries) {
        if (entry.value['code'] == currentLocale.languageCode) {
          languageKey = entry.key;
          break;
        }
      }

      // Only update if the language has actually changed to avoid unnecessary rebuilds
      if (selectedLanguage != languageKey) {
        setState(() {
          selectedLanguage = languageKey;
        });
      }
    } catch (e) {
      print('Error loading saved language: $e');
      // Keep default English if there's an error
    }
  }

  String? username;
  String? mobilenumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "profile_profile".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header Section
            BlocBuilder<FetchProfileBloc, FetchProfileState>(
              builder: (context, state) {
                if (state is FetchProfileLoadingState) {
                  return Container(
                    width: double.infinity,
                    height: ResponsiveUtils.hp(25),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.kprimaryColor,
                          Appcolors.ksecondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.kprimaryColor.withAlpha(77),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SpinKitCircle(
                        size: 20,
                        color: Appcolors.kwhitecolor,
                      ),
                    ),
                  );
                } else if (state is FetchProfileSuccessState) {
                  username = state.user.artisanName;
                  mobilenumber = state.user.artisanMobile;
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.kprimaryColor,
                          Appcolors.ksecondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.kprimaryColor.withAlpha(77),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // User Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Appcolors.kTertiaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Appcolors.kwhitecolor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              state.user.artisanName.substring(0, 1),
                              style: TextStyle(
                                color: Appcolors.kwhitecolor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ResponsiveSizedBox.height15,
                        // User Name
                        Text(
                          state.user.artisanName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.kwhitecolor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Mobile Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_android_rounded,
                              size: 18,
                              color: Appcolors.kwhitecolor.withAlpha(230),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.user.artisanMobile,
                              style: TextStyle(
                                fontSize: 16,
                                color: Appcolors.kwhitecolor.withAlpha(230),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchProfileErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),

            const SizedBox(height: 32),

            // Settings Sections
            _buildSectionTitle("General"),
            const SizedBox(height: 16),

            // Language Setting Card
            _buildSettingCard(
              icon: Icons.language,
              title: "profile_language".tr(),
              subtitle: "profile_chooseyourlanguage".tr(),
              child: _buildLanguageDropdown(),
            ),

            ResponsiveSizedBox.height50,
            // _buildSectionTitle("profile_account".tr()),
            // const SizedBox(height: 16),

            // Logout Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kredcolor.withAlpha(51),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.kTertiaryColor,
                  foregroundColor: Appcolors.kblackcolor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "profile_logout".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ResponsiveSizedBox.height10,
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    CustomNavigation.pushNamedWithTransition(
                      context,
                      AppRouter.deleteaccount,
                      arguments: {
                        'userName': username,
                        'mobileNumber': mobilenumber,
                      },
                    );
                  },
                  child: TextStyles.medium(
                    text: 'Delete Account?',
                    weight: FontWeight.bold,
                    color: Appcolors.kredcolor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Appcolors.kprimaryColor,
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? child,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kblackcolor.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Appcolors.kprimaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Appcolors.kprimaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Appcolors.kblackcolor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Appcolors.kblackcolor.withAlpha(153),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trailing != null) trailing,
                  ],
                ),
                if (child != null) ...[const SizedBox(height: 16), child],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLanguageExpanded = !isLanguageExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Appcolors.ksecondaryColor),
              borderRadius: BorderRadius.circular(8),
              color: Appcolors.kbackgroundcolor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languages[selectedLanguage]!['display']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Appcolors.kblackcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AnimatedRotation(
                  turns: isLanguageExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Appcolors.kprimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isLanguageExpanded ? null : 0,
          child: AnimatedOpacity(
            opacity: isLanguageExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Appcolors.ksecondaryColor),
                borderRadius: BorderRadius.circular(8),
                color: Appcolors.kwhitecolor,
              ),
              child: Column(
                children: languages.entries.map((entry) {
                  final isSelected = selectedLanguage == entry.key;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedLanguage = entry.key;
                          isLanguageExpanded = false;
                        });
                        context.read<LanguageCubit>().changeLanguage(
                          context,
                          Locale(entry.value['code']!),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Appcolors.kprimaryColor.withAlpha(26)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.value['display']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Appcolors.kprimaryColor
                                      : Appcolors.kblackcolor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: Appcolors.kprimaryColor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showLogoutDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Appcolors.kredcolor),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Appcolors.kblackcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Appcolors.kblackcolor.withAlpha(204)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Appcolors.kblackcolor.withAlpha(179)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.kredcolor,
                foregroundColor: Appcolors.kwhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Logout'),
              onPressed: () async {
                await handleLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> handleLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear user token
      await prefs.remove('USER_TOKEN');
      await prefs.remove('FCM_TOKEN');
      await PushNotifications().deleteDeviceToken();
      navigateToMainPageNamed(context, 0);
      // Normal logout - go to login page
      if (context.mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
      }
    } catch (e) {
      print('Error during logout: $e');
      // Fallback navigation
      if (context.mounted) {
        CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
      }
    }
  }
}
