import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';

import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenComplaintsPage extends StatefulWidget {
  const ScreenComplaintsPage({super.key});

  @override
  State<ScreenComplaintsPage> createState() => _ScreenComplaintsPageState();
}

class _ScreenComplaintsPageState extends State<ScreenComplaintsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Hard-coded data for complaints
  final List<ComplaintData> complaints = [
    ComplaintData(
      id: 'CMP001',
      category: 'Plumbing Issue',
      date: '2024-08-15',
      imageUrl:
          'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
    ),
    ComplaintData(
      id: 'CMP002',
      category: 'Electrical Problem',
      date: '2024-08-14',
      imageUrl:
          'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
    ),
    ComplaintData(
      id: 'CMP003',
      category: 'Air Conditioning',
      date: '2024-08-13',
      imageUrl:
          'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
    ),
    ComplaintData(
      id: 'CMP004',
      category: 'Cleaning Service',
      date: '2024-08-12',
      imageUrl:
          'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
    ),
    ComplaintData(
      id: 'CMP005',
      category: 'Maintenance',
      date: '2024-08-11',
      imageUrl:
          'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Complaints'),
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
                hintText: 'Search complaints...',
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
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          Expanded(
            child: complaints.isEmpty
                ? _buildEmptyState()
                : AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];
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
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      CustomNavigation.pushNamedWithTransition(
                                        context,
                                        AppRouter.complaintdetails,
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Complaint ID and Status
                                                Text(
                                                  'Complaint: 34567',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),

                                                ResponsiveSizedBox.height5,

                                                // Category
                                                Text(
                                                  'Category: 23456',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),

                                                ResponsiveSizedBox.height10,

                                                // Date
                                                Text(
                                                  'Date: 12 Feb 2025',
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
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                34,
                                                118,
                                                96,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
