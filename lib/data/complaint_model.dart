class ComplaintModel {
  final String complaintId;
  final String departmentId;
  final String complaintBy;
  final String cityId;
  final String quarterId;
  final String flatId;
  final String categoryId;
  final String complaintRemarks;
  final String imageAddress;
  final String complaintDate;
  final String complaintStatus;
  final String artisanId;
  final String artisansVisitDate;
  final String workerName;
  final String workerMobile;
  final String? remark;
  final String complaintResolutionTime;
  final String complaintOTP;
  final String? verifyOTP;
  final String? repairCost;
  final String? completionPicture;
  final String remarks;
  final String updatedBy;
  final String complaintClosed;
  final String complaintFeedback;

  ComplaintModel({
    required this.complaintId,
    required this.departmentId,
    required this.complaintBy,
    required this.cityId,
    required this.quarterId,
    required this.flatId,
    required this.categoryId,
    required this.complaintRemarks,
    required this.imageAddress,
    required this.complaintDate,
    required this.complaintStatus,
    required this.artisanId,
    required this.artisansVisitDate,
    required this.workerName,
    required this.workerMobile,
    this.remark,
    required this.complaintResolutionTime,
    required this.complaintOTP,
    this.verifyOTP,
    this.repairCost,
    this.completionPicture,
    required this.remarks,
    required this.updatedBy,
    required this.complaintClosed,
    required this.complaintFeedback,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintId: json['complaintId'] ?? '',
      departmentId: json['departmentId'] ?? '',
      complaintBy: json['complaintBy'] ?? '',
      cityId: json['cityId'] ?? '',
      quarterId: json['quarterId'] ?? '',
      flatId: json['flatId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      complaintRemarks: json['complaintremarks'] ?? '',
      imageAddress: json['imageAddress'] ?? '',
      complaintDate: json['complaintDate'] ?? '',
      complaintStatus: json['complaintStatus'] ?? '',
      artisanId: json['artisanId'] ?? '',
      artisansVisitDate: json['artisansVisitDate'] ?? '',
      workerName: json['workerName'] ?? '',
      workerMobile: json['workerMobile'] ?? '',
      remark: json['remark'],
      complaintResolutionTime: json['complaintResolutionTime'] ?? '',
      complaintOTP: json['complaintOTP'] ?? '',
      verifyOTP: json['verifyOTP'],
      repairCost: json['repairCost'],
      completionPicture: json['completionPicture'],
      remarks: json['remarks'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      complaintClosed: json['complaintClosed'] ?? '',
      complaintFeedback: json['complaintFeedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "complaintId": complaintId,
      "departmentId": departmentId,
      "complaintBy": complaintBy,
      "cityId": cityId,
      "quarterId": quarterId,
      "flatId": flatId,
      "categoryId": categoryId,
      "complaintremarks": complaintRemarks,
      "imageAddress": imageAddress,
      "complaintDate": complaintDate,
      "complaintStatus": complaintStatus,
      "artisanId": artisanId,
      "artisansVisitDate": artisansVisitDate,
      "workerName": workerName,
      "workerMobile": workerMobile,
      "remark": remark,
      "complaintResolutionTime": complaintResolutionTime,
      "complaintOTP": complaintOTP,
      "verifyOTP": verifyOTP,
      "repairCost": repairCost,
      "completionPicture": completionPicture,
      "remarks": remarks,
      "updatedBy": updatedBy,
      "complaintClosed": complaintClosed,
      "complaintFeedback": complaintFeedback,
    };
  }
}
