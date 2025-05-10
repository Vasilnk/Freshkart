import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshkart/view/screens/account/about_screen.dart';
import 'package:freshkart/view/screens/account/addresses_page.dart';
import 'package:freshkart/view/screens/account/help_screen.dart';
import 'package:freshkart/view/screens/account/my_details.dart';
import 'package:freshkart/view/screens/account/order/orders_screen.dart';
import 'package:freshkart/view/screens/account/privacy_policy_screen.dart';
import 'package:freshkart/view/screens/account/wishlilst_screen.dart';
import 'package:freshkart/view/screens/authentication/forget_password.dart';
import 'package:freshkart/view/screens/authentication/login_screen.dart';
import 'package:freshkart/view/screens/authentication/signup_screen.dart';
import 'package:freshkart/view/screens/authentication/splash_screen.dart';
import 'package:freshkart/view/screens/authentication/welcome_screen.dart';
import 'package:freshkart/view/screens/home/search_screen.dart';
import 'package:freshkart/view/screens/landing_screen.dart';
import 'package:freshkart/view/screens/products/products_page.dart';
import 'package:freshkart/view/screens/products/single_product_page.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String splash = '/';
  static const String landing = '/home';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgot = '/forgot';
  static const String search = '/search';
  static const String myDetails = '/myDetails';
  static const String orders = '/orders';
  static const String deliveryAddress = '/deliveryAddress';
  static const String wishlist = '/wishlist';
  static const String help = '/help';
  static const String about = '/about';
  static const String productPage = '/product';
  static const String productsScreen = '/category';
  static const String privacyPolicy = '/privacyPolicy';

  static List<RouteBase> routeBase = [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.landing,
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: Routes.welcome,
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return const LandingScreen();
        }

        return const WelcomeScreen();
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return const LandingScreen();
        }
        return LoginScreen();
      },
    ),
    GoRoute(path: Routes.signup, builder: (context, state) => SignupScreen()),
    GoRoute(path: Routes.forgot, builder: (context, state) => ForgetPassword()),
    GoRoute(
      path: Routes.privacyPolicy,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),

    GoRoute(
      path: Routes.myDetails,
      builder: (context, state) => const MyDetails(),
    ),
    GoRoute(
      path: Routes.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: Routes.deliveryAddress,
      builder: (context, state) => const AddressesPage(),
    ),
    GoRoute(
      path: Routes.wishlist,
      builder: (context, state) => const WishlistScreen(),
    ),
    GoRoute(path: Routes.help, builder: (context, state) => HelpScreen()),
    GoRoute(
      path: Routes.about,
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: Routes.search,
      builder: (context, state) => const SearchProductScreen(),
    ),
    GoRoute(
      path: Routes.productPage,
      builder: (context, state) => const ProductPage(),
    ),
    GoRoute(
      path: Routes.productsScreen,
      builder: (context, state) {
        final categoryId = context.read<CategoryProvider>().categoryName;
        return ProductsPage(productType: categoryId);
      },
    ),
  ];
}
