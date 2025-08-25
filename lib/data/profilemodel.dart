class Profilemodel {
  final String artisanId;
  final String departmentId;
  final String cityId;
  final String categoryId;
  final String artisanName;
  final String artisanMobile;
  final String? artisanOtp;
  final String? pushToken;
  final String artisanCreatedBy;
  final String artisandCreatedDateTime;

  Profilemodel({
    required this.artisanId,
    required this.departmentId,
    required this.cityId,
    required this.categoryId,
    required this.artisanName,
    required this.artisanMobile,
    this.artisanOtp,
    this.pushToken,
    required this.artisanCreatedBy,
    required this.artisandCreatedDateTime,
  });

  // From JSON
  factory Profilemodel.fromJson(Map<String, dynamic> json) {
    return Profilemodel(
      artisanId: json['artisanId'] ?? "",
      departmentId: json['departmentId'] ?? "",
      cityId: json['cityId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      artisanName: json['artisanName'] ?? "Q",
      artisanMobile: json['artisanMobile'] ?? "",
      artisanOtp: json['artisanOtp'],
      pushToken: json['pushToken'],
      artisanCreatedBy: json['artisanCreatedBy'] ?? "",
      artisandCreatedDateTime: json['artisandCreatedDateTime'] ?? "",
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'artisanId': artisanId,
      'departmentId': departmentId,
      'cityId': cityId,
      'categoryId': categoryId,
      'artisanName': artisanName,
      'artisanMobile': artisanMobile,
      'artisanOtp': artisanOtp,
      'pushToken': pushToken,
      'artisanCreatedBy': artisanCreatedBy,
      'artisandCreatedDateTime': artisandCreatedDateTime,
    };
  }
}
