import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';

import 'package:qcms_artisan/presentation/bloc/fetch_solvedcomplaints/fetch_solvedcomplaints_bloc.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';

import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenSolvedcomplaintspage extends StatefulWidget {
  
  
  const ScreenSolvedcomplaintspage({super.key});

  @override
  State<ScreenSolvedcomplaintspage> createState() =>
      _ScreenComplaintsPageState();
}

class _ScreenComplaintsPageState extends State<ScreenSolvedcomplaintspage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
     _searchController.addListener(_onTextChanged);
    context.read<FetchSolvedcomplaintsBloc>().add(
      FetchsolvedComplaintsInitialEvent(),
    );
  }
  void _onTextChanged() {
    setState(() {}); // Only rebuild when text changes
  }
  void _onSearchChanged(String query) {
    context.read<FetchSolvedcomplaintsBloc>().add(
      SearchsolvedComplaintsEvent(query: query),
    );
  }

  Future<void> _onRefresh() async {
    // Clear search if there's any active search
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
    }

    // Trigger refresh event
    context.read<FetchSolvedcomplaintsBloc>().add(
      FetchsolvedComplaintsInitialEvent(),
    );
    // Wait for the state to update
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:  "completed_completedcomplaints".tr()),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            height: ResponsiveUtils.hp(6),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Appcolors.kTertiaryColor, width: .5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(33),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search completed complaints by Id...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400]),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          BlocBuilder<FetchSolvedcomplaintsBloc, FetchSolvedcomplaintsState>(
            builder: (context, state) {
              if (state is FetchsolvedComplaintlistsLoadingState) {
                return ListView.builder(
                      padding: const EdgeInsets.only(
      left: 15,
      right: 15,
      top: 15,
    ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      height: ResponsiveUtils.hp(15),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(20),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SpinKitCircle(
                          size: 20,
                          color: Appcolors.ksecondaryColor,
                        ),
                      ),
                    );
                  },
                );
              } else if (state is FetchsolvedComplaintsErrorState) {
                  return Container(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                   context.read<FetchSolvedcomplaintsBloc>().add(
      FetchsolvedComplaintsInitialEvent(),
    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.ksecondaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
              } else if (state is FetchsolvedComplaintlistSuccessState) {
                  final complaintsToShow = state.filteredComplaints;

                return Expanded(
                  child: complaintsToShow.isEmpty
                      ? _buildEmptyState()
                      : AnimationLimiter(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                            ),
                            itemCount: complaintsToShow.length,
                            itemBuilder: (context, index) {
                              final complaint = complaintsToShow[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withAlpha(20),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            CustomNavigation.pushNamedWithTransition(
                                              context,
                                              AppRouter.completedcomplaintdetails,
                                              arguments: {
                                                'complaintdetails': complaint,
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Complaint ID and Status
                                                      Text(
                                                        'Complaint: ${complaint.complaintId}',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black87,
                                                        ),
                                                      ),

                                                      ResponsiveSizedBox
                                                          .height5,

                                                      // Category
                                                      Text(
                                                        'Category: ${complaint.categoryId}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black54,
                                                        ),
                                                      ),

                                                      ResponsiveSizedBox
                                                          .height10,

                                                      // Date
                                                      Text(
                                                        'Date: ${DateFormat('d MMM yyyy').format(DateTime.parse(complaint.complaintDate))}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Arrow Icon
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      34,
                                                      118,
                                                      96,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }



  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Complaints Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your complaints will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }


}

// Data model for complaints
class ComplaintData {
  final String id;
  final String category;
  final String date;
  final String imageUrl;

  ComplaintData({
    required this.id,
    required this.category,
    required this.date,
    required this.imageUrl,
  });
}
