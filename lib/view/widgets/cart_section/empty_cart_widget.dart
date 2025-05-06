import 'package:flutter/material.dart';
import 'package:freshkart/view/screens/landing_screen.dart';
import 'package:freshkart/core/utils/colors.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/gif/Animation - 1743259698821.gif'),
          const Text(
            'Your cart is empty ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const LandingScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Continue shopping',
              style: TextStyle(color: AppColors.greenColor),
            ),
          ),
        ],
      ),
    );
  }
}
