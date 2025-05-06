import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/user_model.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserServices userServices = UserServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<String?> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = (await auth.signInWithCredential(credential));
      final user = userCredential.user;
      UserServices.user = user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? 'Unknown',
          name: user.displayName ?? 'Unknown',
        );
        await userServices.saveUserDataToFirestore(userModel);
        await userServices.fetchUserDataFromFirestore(user.uid);
      }
      notifyListeners();
      return 'success';
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
