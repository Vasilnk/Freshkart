import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getAllNotifications() async {
    final snapshot = await firestore.collection('notifications').get();
    final data = snapshot.docs;
    return data.map((doc) => doc.data()).toList();
  }
}
