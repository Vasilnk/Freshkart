import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/notification_services.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationServices notificationServices = NotificationServices();
  List<Map<String, dynamic>> notifications = [];
  getAllNotifications() async {
    notifications = await notificationServices.getAllNotifications();
  }
}
