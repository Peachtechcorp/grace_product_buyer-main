List<UserNotification> getNotificationFromJson(List json) => List.generate(
      json.length,
      (index) => UserNotification(
        id: json[index]['id'],
        title: json[index]['title'],
        description: json[index]['description'],
        time: json[index]['time'],
      ),
    );

enum NotificationType {
  offer,
  service,
  connected,
}

class UserNotification {
  int id;
  String title;
  String description;
  String time;
  NotificationType notificationType;

  UserNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.notificationType = NotificationType.connected,
  });
}
