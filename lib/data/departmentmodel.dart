class DepartmentModel {
  final String departmentId;
  final String departmentName;

  DepartmentModel({
    required this.departmentId,
    required this.departmentName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: json['departmentId'] ?? '',
      departmentName: json['departmentName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentId': departmentId,
      'departmentName': departmentName,
    };
  }
}
