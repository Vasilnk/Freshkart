import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: isWeb ? buildWebLayout(context) : buildMobileLayout(context),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.welcomeImage, fit: BoxFit.cover),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Welcome', style: AppStyles.welcomText),
              Text('to our store', style: AppStyles.welcomText),
              const Text(
                'Get your groceries in as fast as one hour',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: () => context.replace(Routes.login),
                  style: AppStyles.bigButton,
                  child: Text(
                    'Get Started',
                    style: AppStyles.bigButtonTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildWebLayout(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.webWelcomeImage, fit: BoxFit.cover),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to our store',
                  style: AppStyles.welcomText.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Get your groceries in as fast as one hour',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => context.replace(Routes.login),
                  style: AppStyles.bigButton,
                  child: Text(
                    'Get Started',
                    style: AppStyles.bigButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
