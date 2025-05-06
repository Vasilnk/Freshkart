import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view/screens/account/order/orders_screen.dart';
import 'package:freshkart/view/screens/landing_screen.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/styles.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  final AudioPlayer audio = AudioPlayer();

  playTune() {
    audio.play(AssetSource('tunes/success.mp3'));
  }

  @override
  void initState() {
    playTune();
    super.initState();
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    playTune();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 30,
            children: [
              Center(child: Image.asset('assets/images/orderplaced.png')),
              Text(
                'Order Placed !',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greenColor,
                ),
              ),
              const Text(
                '''Your items has been placed and is on 
                  it’s way to being processed''',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.popUntil(context, (route) => route.isFirst);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const OrdersScreen()),
                    );
                  },
                  style: AppStyles.bigButton,
                  child: Text('Track now', style: AppStyles.bigButtonTextStyle),
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
        ),
      ),
    );
  }
}
