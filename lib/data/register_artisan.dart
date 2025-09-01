class RegisterArtisanModel {
  final String divisionName;
  final String departmentName;
  final String artisanName;
  final String artisanMobile;

  RegisterArtisanModel({
    required this.divisionName,
    required this.departmentName,
    required this.artisanName,
    required this.artisanMobile,
  });

  // Convert JSON → Model
  factory RegisterArtisanModel.fromJson(Map<String, dynamic> json) {
    return RegisterArtisanModel(
      divisionName: json['divisionName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      artisanName: json['artisanName'] ?? '',
      artisanMobile: json['artisanMobile'] ?? '',
    );
  }

  // Convert Model → JSON (for API request)
  Map<String, dynamic> toJson() {
    return {
      "divisionName": divisionName,
      "departmentName": departmentName,
      "artisanName": artisanName,
      "artisanMobile": artisanMobile,
    };
  }
}
