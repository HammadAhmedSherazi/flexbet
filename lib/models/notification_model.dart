class NotificationModel {
  final String userId;
  final String body;
  final String type;
  final dynamic creationDate;
  final String title;



  NotificationModel({
    required this.userId,
    required this.body,
    required this.type,
    required this.creationDate,
    required this.title,

  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      userId: json['id'],
      body: json['body'],
      type: json['type'],
      creationDate: json['creationDate'],
      title: json['title'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'body': body,
      'type': type,
      'creationDate': creationDate,
      'title': title,
    };
  }
}
