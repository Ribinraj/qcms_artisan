class DivisionsModel {
  final String cityId;
  final String cityName;

  DivisionsModel({
    required this.cityId,
    required this.cityName,
  });

  factory DivisionsModel.fromJson(Map<String, dynamic> json) {
    return DivisionsModel(
      cityId: json['cityId'] ?? '',
      cityName: json['cityName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'cityName': cityName,
    };
  }
}