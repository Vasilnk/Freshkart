import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String currentStatus;
  OrderTrackingScreen({super.key, required this.currentStatus});
  final List<String> allStatuses = [
    'Pending',
    'Confirmed',
    'Packed',
    'Out for Delivery',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    int currentStep = allStatuses.indexOf(currentStatus);

    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: currentStep,
      steps:
          allStatuses.map((status) {
            int stepIndex = allStatuses.indexOf(status);
            return Step(
              title: Text(status),
              content: Text('Your Order is $status'),
              isActive: stepIndex <= currentStep,
              state:
                  stepIndex <= currentStep
                      ? StepState.complete
                      : StepState.indexed,
            );
          }).toList(),
      controlsBuilder: (context, _) => const SizedBox.shrink(),
    );
  }
}
