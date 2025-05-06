import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});
  final List<Map<String, String>> helpItems = [
    {
      'question': 'How to place an order?',
      'answer': 'Browse items, add to cart, and proceed to checkout easily.',
    },
    {
      'question': 'What are the delivery timings?',
      'answer': 'Deliveries are made daily between 7 AM to 9 PM.',
    },
    {
      'question': 'Which payment methods are accepted?',
      'answer': 'We accept Debit/Credit Cards and Cash on Delivery.',
    },
    {
      'question': 'What is your return policy?',
      'answer':
          'You can request a return within 24 hours of delivery only on non edible products.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Help & Support'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.support_agent, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  'Need help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Find answers to common questions below.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: helpItems.length,
              itemBuilder: (context, index) {
                final item = helpItems[index];
                return Card(
                  elevation: 2,
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: AppColors.greenColor,
                    ),
                    title: Text(
                      item['question']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(item['answer']!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
