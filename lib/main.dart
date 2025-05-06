import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshkart/core/routes.dart';

import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/view_model/providers/auth/google_provider.dart';
import 'package:freshkart/view_model/providers/auth/login_provider.dart';
import 'package:freshkart/view_model/providers/auth/logout_provider.dart';
import 'package:freshkart/view_model/providers/auth/signup_provider.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:freshkart/view_model/providers/cover_image_provider.dart';
import 'package:freshkart/view_model/providers/notification_provider.dart';
import 'package:freshkart/view_model/providers/order_provider.dart';
import 'package:freshkart/view_model/providers/payment_provider.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/view_model/providers/auth/location_provider.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = publishbleKey;
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

GoRouter router = GoRouter(
  routes: Routes.routeBase,
  redirect: (context, state) {
    if (kIsWeb) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;

      if (!isLoggedIn) return Routes.login;
      if (isLoggedIn && state.matchedLocation == Routes.login) {
        return Routes.landing;
      }
    }
    return null;
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => LogoutProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CoverImageProvider()),
        ChangeNotifierProvider(create: (context) => WshlistProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => GoogleProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Freshkart',
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: AppColors.greenColor),
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(fontSize: 15, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 13, color: Colors.black),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
          ),

          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black54),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
