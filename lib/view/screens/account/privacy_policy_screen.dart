import 'package:flutter/material.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: 'Privacy Policy'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Last updated: [Insert Date]',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'We only collect the following details:\n\n'
              '- Email Address\n'
              '- Name\n'
              '- Location\n\n'
              'These are used only for:\n'
              '- Signing in (authentication)\n'
              '- Displaying your profile within the app\n\n'
              'We do not collect any other personal data such as:\n'
              '- Phone number\n'
              '- Address or ZIP code\n'
              '- Usage analytics or device data',
            ),
            SizedBox(height: 20),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Your email and name are used:\n'
              '- To verify your identity and log you into the app\n'
              '- To show your name in relevant parts of the app (e.g., profile section)\n\n'
              'We do not:\n'
              '- Share or sell your data to third parties\n'
              '- Use your information for advertising or marketing\n'
              '- Track your app usage',
            ),
            SizedBox(height: 20),
            Text(
              '3. Data Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'We take your data security seriously and use secure methods to store and handle your information.',
            ),
            SizedBox(height: 20),
            Text(
              '4. No Third-Party Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'This app does not use third-party services like ads or analytics tools. Your data stays private within the app.',
            ),
            SizedBox(height: 20),
            Text(
              '5. Children’s Privacy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Our app is not intended for children under 13. We do not knowingly collect data from children.',
            ),
            SizedBox(height: 20),
            Text(
              '6. Updates to This Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'If we make changes to this policy, we will update this screen with the new date.',
            ),
            SizedBox(height: 20),
            Text(
              '7. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions, feel free to reach out:\n'
              'vasilnk6@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}
