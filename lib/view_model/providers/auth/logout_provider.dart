import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> logOut() async {
    try {
      bool? isGoogleUser = auth.currentUser?.providerData.any(
        (info) => info.providerId == 'google.com',
      );
      if (isGoogleUser == true) {
        await GoogleSignIn().signOut();
      }

      await FirebaseAuth.instance.signOut();
      UserServices.currentUser = null;
      UserServices.user = null;
      return 'success';
    } on FirebaseAuthException {
      return 'Logout error';
    }
  }
}
