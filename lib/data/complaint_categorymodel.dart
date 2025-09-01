class ComplaintCategorymodel {
  final String categoryId;
  final String departmentId;
  final String categoryName;
  final String pictureRequired;
  final String otpAuthentication;

  ComplaintCategorymodel({
    required this.categoryId,
    required this.departmentId,
    required this.categoryName,
    required this.pictureRequired,
    required this.otpAuthentication,
  });

  factory ComplaintCategorymodel.fromJson(Map<String, dynamic> json) {
    return ComplaintCategorymodel(
      categoryId: json['categoryId'] ?? '',
      departmentId: json['departmentId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      pictureRequired: json['pictureRequired'] ?? '',
      otpAuthentication: json['OTPauthentication'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'departmentId': departmentId,
      'categoryName': categoryName,
      'pictureRequired': pictureRequired,
      'OTPauthentication': otpAuthentication,
    };
  }
}
