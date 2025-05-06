import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/screens/authentication/signup_screen.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/text_field/text_field.dart';
import 'package:go_router/go_router.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final emailController = TextEditingController();
  final emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.spreadedImage),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 330),
                  const Text(
                    'Forget password',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),

                  const Text(
                    'Enter your email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Form(
                    key: emailKey,
                    child: CustomTextFormField(
                      label: 'Email',
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Column(
                    spacing: 13,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (emailKey.currentState!.validate()) {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text.trim(),
                            );
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    'A password recovery link has been sent to your email !',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  actions: [
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.greenColor,
                                        ),
                                        onPressed: () {
                                          context.go(Routes.login);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: AppStyles.bigButton,
                        child: Text(
                          'Send to email',
                          style: AppStyles.bigButtonTextStyle,
                        ),
                      ),
                      const SizedBox(height: 75),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an account?'),
                          InkWell(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                ),
                            child: Text(
                              ' SignUp',
                              style: TextStyle(
                                color: AppColors.greenColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
