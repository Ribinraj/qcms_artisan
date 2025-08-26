class NotificationModel {
  final String notificationId;
  final String recipient;
  final String recipientId;
  final String notification;
  final String status;
  final CreatedAt createdAt;
  final String modifiedAt;

  NotificationModel({
    required this.notificationId,
    required this.recipient,
    required this.recipientId,
    required this.notification,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] ?? '',
      recipient: json['recipient'] ?? '',
      recipientId: json['recipientId'] ?? '',
      notification: json['notification'] ?? '',
      status: json['status'] ?? '',
      createdAt: CreatedAt.fromJson(json['created_at']),
      modifiedAt: json['modified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "notificationId": notificationId,
      "recipient": recipient,
      "recipientId": recipientId,
      "notification": notification,
      "status": status,
      "created_at": createdAt.toJson(),
      "modified_at": modifiedAt,
    };
  }
}

class CreatedAt {
  final String date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date'] ?? '',
      timezoneType: json['timezone_type'] ?? 0,
      timezone: json['timezone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "timezone_type": timezoneType,
      "timezone": timezone,
    };
  }
}
