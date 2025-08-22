import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_networkimage.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenSolvedcomplaintspage extends StatefulWidget {
  const ScreenSolvedcomplaintspage({super.key});

  @override
  State<ScreenSolvedcomplaintspage> createState() =>
      _ScreenComplaintsPageState();
}

class _ScreenComplaintsPageState extends State<ScreenSolvedcomplaintspage> {
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
      appBar: const CustomAppBar(title: 'Competed Complaints'),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            height: ResponsiveUtils.hp(6),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Appcolors.ksecondaryColor, width: .5),
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
                hintText: 'Search solved complaints...',
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
                              child: _buildComplaintCard(complaint),
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

  Widget _buildComplaintCard(ComplaintData complaint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withAlpha(50), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(25),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.green.withAlpha(15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          CustomNavigation.pushNamedWithTransition(
            context,
            AppRouter.complaintdetails,
          );
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.green.withAlpha(44),
        highlightColor: Colors.green.withAlpha(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Complaint Image with enhanced styling
              ImageWithFallback(
                imageUrl: complaint.imageUrl,
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(10),
              ),
              ResponsiveSizedBox.width20,
              // Complaint Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(25),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.green.withAlpha(40),
                          width: 0.5,
                        ),
                      ),
                      child: ResponsiveText(
                        complaint.id,
                        weight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    ResponsiveSizedBox.height5,
                    // Complaint Category
                    TextStyles.body(
                      text: complaint.category,
                      color: Colors.green[600],
                    ),
                    ResponsiveSizedBox.height5,
                    // Date Row with green styling
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(35),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: Colors.green[600],
                          ),
                        ),
                        ResponsiveSizedBox.width5,
                        TextStyles.medium(
                          text: complaint.date,
                          color: Colors.green[600],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Green themed Arrow Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
        ),
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
