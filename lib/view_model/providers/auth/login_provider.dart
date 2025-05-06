import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class LoginProvider extends ChangeNotifier {
  UserServices userServices = UserServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<String?> login({required email, required password}) async {
    isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userServices.fetchUserDataFromFirestore(userCredential.user!.uid);

      isLoading = false;
      notifyListeners();
      return 'success';
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();

      return e.toString();
    }
  }
}
