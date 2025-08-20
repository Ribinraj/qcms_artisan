import 'package:flutter/material.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';

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
      imageUrl: 'https://via.placeholder.com/80x80/E3F2FD/1976D2?text=IMG',
    ),
    ComplaintData(
      id: 'CMP002',
      category: 'Electrical Problem',
      date: '2024-08-14',
      imageUrl: 'https://via.placeholder.com/80x80/FFF3E0/F57C00?text=IMG',
    ),
    ComplaintData(
      id: 'CMP003',
      category: 'Air Conditioning',
      date: '2024-08-13',
      imageUrl: 'https://via.placeholder.com/80x80/E8F5E8/388E3C?text=IMG',
    ),
    ComplaintData(
      id: 'CMP004',
      category: 'Cleaning Service',
      date: '2024-08-12',
      imageUrl: 'https://via.placeholder.com/80x80/FCE4EC/E91E63?text=IMG',
    ),
    ComplaintData(
      id: 'CMP005',
      category: 'Maintenance',
      date: '2024-08-11',
      imageUrl: 'https://via.placeholder.com/80x80/F3E5F5/9C27B0?text=IMG',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Solved Complaints'),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
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
                hintText: 'Search solved complaints...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 24,
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
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaints[index];
                      return _buildComplaintCard(complaint);
                    },
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
        border: Border.all(
          color: Appcolors.ksecondaryColor.withAlpha(33),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kprimaryColor.withAlpha(22),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Appcolors.kprimaryColor.withAlpha(15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Handle complaint tap - navigate to detail page
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: Appcolors.ksecondaryColor.withAlpha(44),
        highlightColor: Appcolors.ksecondaryColor.withAlpha(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Complaint Image with enhanced styling
              Container(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Appcolors.ksecondaryColor.withAlpha(77),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.kprimaryColor.withAlpha(33),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.network(
                    complaint.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Appcolors.ksecondaryColor.withAlpha(33),
                        ),
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Appcolors.kTertiaryColor.withAlpha(200),
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              ResponsiveSizedBox.width20,
              // Complaint Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Complaint Number with accent
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Appcolors.kprimaryColor.withAlpha(22),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Appcolors.kprimaryColor.withAlpha(33),
                              width: 0.5,
                            ),
                          ),
                          child: ResponsiveText(
                            complaint.id,
                            weight: FontWeight.bold,
                            color: Appcolors.kprimarytextColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Appcolors.kTertiaryColor.withAlpha(44),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Appcolors.kTertiaryColor.withAlpha(66),
                              width: 0.5,
                            ),
                          ),
                          child: TextStyles.caption(
                            text: "Solved",
                            weight: FontWeight.bold,
                            color: Appcolors.kTertiaryColor,
                          ),
                        ),
                      ],
                    ),
                    ResponsiveSizedBox.height5,
                    // Complaint Category
                    TextStyles.body(
                      text: complaint.category,
                      color: Appcolors.kTertiaryColor,
                    ),
                    ResponsiveSizedBox.height5,
                    // Date Row with enhanced styling
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Appcolors.kTertiaryColor.withAlpha(33),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: Appcolors.kTertiaryColor,
                          ),
                        ),
                        ResponsiveSizedBox.width5,
                        TextStyles.medium(
                          text: complaint.date,
                          color: Appcolors.kTertiaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Enhanced Arrow Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolors.ksecondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Appcolors.ksecondaryColor,
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
