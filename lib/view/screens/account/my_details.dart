import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/account_section/my_details_container.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class MyDetails extends StatelessWidget {
  const MyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserServices.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: AppColors.greenColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        UserServices.user?.photoURL != null
                            ? NetworkImage(UserServices.user?.photoURL ?? '')
                            : null,
                    backgroundColor: Colors.grey[300],
                    child:
                        UserServices.user?.photoURL == null
                            ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                            : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'Unknown Email',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle("Account Information"),
            const SizedBox(height: 10),
            MyDetailsContainer(title: 'Name', value: user?.name ?? 'Unknown'),
            MyDetailsContainer(title: 'Email', value: user?.email ?? 'Unknown'),
            const MyDetailsContainer(
              title: 'Account Type',
              value: 'Regular User',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
