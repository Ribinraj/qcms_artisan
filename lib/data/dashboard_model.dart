class DashboardModel {
  final String openComplaints;
  final String completedComplaints;

  DashboardModel({
    required this.openComplaints,
    required this.completedComplaints,
  });

  // From JSON
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      openComplaints: json['openComplaints'] ?? "0",
      completedComplaints: json['completedComplaints'] ?? "0",
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'openComplaints': openComplaints,
      'completedComplaints': completedComplaints,
    };
  }
}
