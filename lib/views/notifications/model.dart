class NotificationModel {
  late int id;
  late final String image, title, body, time;

  NotificationModel({
    this.id = 0,
    required this.image,
    required this.title,
    required this.body,
    required this.time,
  });
}
