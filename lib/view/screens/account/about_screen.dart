import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('About FreshKart'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'FreshKart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your daily grocery partner.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.green,
                    ),
                    title: Text('Version'),
                    subtitle: Text('1.0.0'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: Colors.green,
                    ),
                    title: Text('About'),
                    subtitle: Text(
                      'FreshKart brings fresh groceries and daily essentials directly to your door. Our goal is to provide high-quality, affordable, and fast service to all our customers.',
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.green),
                    title: Text('Developed by'),
                    subtitle: Text('Team FreshKart'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email_outlined, color: Colors.green),
                    title: Text('Contact'),
                    subtitle: Text('vasilnk6@gmail.com'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
