import 'package:flutter/material.dart';
import 'package:freshkart/view/screens/landing_screen.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/images.dart';

class FailedPaymentDisplay extends StatelessWidget {
  const FailedPaymentDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Stack(
        children: [
          Column(
            spacing: 20,
            children: [
              Image.asset(AppImages.failedImage),
              const Text(
                'Oops! Order Failed',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 228, 74, 63),
                ),
              ),
              const Text(
                'Something went wrong.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(130, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: AppColors.greenColor,
                ),
                child: const Text(
                  'Please Try Again',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              InkWell(
                child: const Text(
                  'Back to home',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const LandingScreen()),
                  );
                },
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
