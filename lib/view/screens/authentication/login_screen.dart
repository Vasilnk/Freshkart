import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/snackbar.dart';
import 'package:freshkart/view/widgets/text_field/text_field.dart';
import 'package:freshkart/view_model/providers/auth/google_provider.dart';
import 'package:freshkart/view_model/providers/auth/login_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final loginKey = GlobalKey<FormState>();
initState((){});
  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: isWeb ? buildWebLayout(context) : buildMobileLayout(context),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Stack(
      children: [
        Image.asset(AppImages.spreadedImage),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.38),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Enter your e-mail and password',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Form(
                  key: loginKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'Email',
                        controller: emailController,
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        label: 'Password',
                        isPasswordField: true,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Column(
                  spacing: 7,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: const Text('forgot password?'),
                        onTap: () => context.push(Routes.forgot),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (loginKey.currentState!.validate()) {
                          String? result = await loginProvider.login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          if (result == 'success') {
                            context.go(Routes.landing);
                          } else {
                            CustomSnackbar.showCustomSnackBar(
                              context,
                              'Username or password incorrect',
                            );
                          }
                        }
                      },
                      style: AppStyles.bigButton,
                      child:
                          loginProvider.isLoading
                              ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                              : Text(
                                'Login',
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
                            'Failed Google Login',
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset(AppImages.googleIconImage),
                            ),
                            const SizedBox(width: 15),
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
                        const Text('Don\'t have an account?'),
                        InkWell(
                          onTap: () => context.push(Routes.signup),
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
    );
  }

  Widget buildWebLayout(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.spreadedImage, fit: BoxFit.cover),
        ),
        Center(
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: loginKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your e-mail and password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => context.push(Routes.forgot),
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (loginKey.currentState!.validate()) {
                        String? result = await loginProvider.login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        if (result == 'success') {
                          context.go(Routes.landing);
                        } else {
                          CustomSnackbar.showCustomSnackBar(
                            context,
                            'Username or password incorrect',
                          );
                        }
                      }
                    },
                    style: AppStyles.bigButton,
                    child:
                        loginProvider.isLoading
                            ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                            : Text(
                              'Login',
                              style: AppStyles.bigButtonTextStyle,
                            ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Or connect with social media'),
                  const SizedBox(height: 10),
                  OutlinedButton(
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
                          'Failed Google Login',
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset(AppImages.googleIconImage),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      InkWell(
                        onTap: () => context.push(Routes.signup),
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
            ),
          ),
        ),
      ],
    );
  }
}
