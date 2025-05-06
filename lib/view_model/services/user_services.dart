import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshkart/models/user_model.dart';

class UserServices {
  static User? user;
  static UserModel? currentUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  saveUserDataToFirestore(UserModel user) async {
    try {
      firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      throw FirebaseException;
    }
    fetchUserDataFromFirestore(user.uid);
  }

  fetchUserDataFromFirestore(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.data() != null) {
      currentUser = UserModel.fromMap(snapshot.data()!);
    }
  }
}
