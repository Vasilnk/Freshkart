import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/user_model.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class SignupProvider extends ChangeNotifier {
  UserServices userServices = UserServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isPrivacyAgreed = false;
  set privacyAgree(bool value) {
    isPrivacyAgreed = value;
    notifyListeners();
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      if (userCredential.user != null) {
        final user = userCredential.user;
        final currentUser = UserModel(
          uid: user?.uid ?? '',
          email: user?.email ?? email,
          name: user?.displayName ?? name,
          location: 'Unknown',
        );
        userServices.saveUserDataToFirestore(currentUser);
      }

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
