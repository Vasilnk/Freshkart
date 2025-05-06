import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userServices = UserServices();

      if (currentUser != null) {
        await userServices.fetchUserDataFromFirestore(currentUser.uid);
        UserServices.user = currentUser;
        context.replace(Routes.landing);
      } else {
        context.replace(Routes.welcome);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 190,
          width: 190,
          child: Image.asset(AppImages.logoImage),
        ),
      ),
    );
  }
}
