import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/view_model/providers/auth/google_provider.dart';
import 'package:freshkart/view_model/providers/auth/signup_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/snackbar.dart';
import 'package:freshkart/view/widgets/text_field/text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final signupKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignupProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isWeb = width > 450;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: isWeb ? double.infinity : 250,
            child: Image.asset(
              isWeb ? AppImages.signupWebImage : AppImages.signupImage,
              fit: BoxFit.cover,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = width;
              if (constraints.maxWidth > 1000) {
                containerWidth = width * 0.4;
              } else if (constraints.maxWidth > 800) {
                containerWidth = width * 0.5;
              } else if (constraints.maxWidth > 600) {
                containerWidth = width * 0.6;
              } else if (constraints.maxWidth > 450) {
                containerWidth = width * 0.8;
              }
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(isWeb ? 18.0 : 0),
                  child: Container(
                    padding: EdgeInsets.all(isWeb ? 10 : 0),
                    width: containerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isWeb ? Colors.white : Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isWeb ? 0 : height * 0.26),
                            const Align(
                              alignment:
                                  kIsWeb
                                      ? Alignment.center
                                      : Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Create your account',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 5),
                            Form(
                              key: signupKey,
                              child: Column(
                                spacing: 13,

                                children: [
                                  CustomTextFormField(
                                    controller: usernameController,
                                    label: 'User name',
                                  ),

                                  CustomTextFormField(
                                    controller: emailController,
                                    label: 'Email',
                                  ),
                                  CustomTextFormField(
                                    isPasswordField: true,
                                    controller: passwordController,
                                    label: 'Password',
                                  ),

                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Column(
                              spacing: 13,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      onChanged: (value) {},
                                      value: true,
                                      activeColor: AppColors.greenColor,
                                    ),
                                    const Text(
                                      '''I agree to the Terms of Service and  
Privacy Policy''',
                                    ),
                                  ],
                                ),

                                ElevatedButton(
                                  onPressed: () async {
                                    if (signupKey.currentState!.validate()) {
                                      String? result = await signUpProvider
                                          .signUp(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            name:
                                                usernameController.text.trim(),
                                          );

                                      if (result == 'success') {
                                        context.go(Routes.landing);
                                      } else {
                                        CustomSnackbar.showCustomSnackBar(
                                          context,
                                          result!,
                                        );
                                      }
                                    }
                                  },
                                  style: AppStyles.bigButton,
                                  child:
                                      signUpProvider.isLoading == true
                                          ? const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                          : Text(
                                            'Sign Up',
                                            style: AppStyles.bigButtonTextStyle,
                                          ),
                                ),
                                const Text('Or connect with social media'),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    String? result =
                                        await context
                                            .read<GoogleProvider>()
                                            .signinWithGoogle();
                                    if (result == 'success') {
                                      context.go(Routes.landing);
                                    } else {
                                      CustomSnackbar.showCustomSnackBar(
                                        context,
                                        'Google SignUp Failed',
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    child: Row(
                                      spacing: 25,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 40,
                                          child: Image.network(
                                            AppImages.googleIconImage,
                                          ),
                                        ),
                                        const Text(
                                          'Continue with google',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Alreday have an account?'),
                                    InkWell(
                                      onTap: () {
                                        context.replace(Routes.login);
                                      },
                                      child: Text(
                                        ' Sign in',
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
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
