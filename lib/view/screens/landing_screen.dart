import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:freshkart/view_model/providers/notification_provider.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/view/screens/cart/cart_page.dart';
import 'package:freshkart/view/screens/products/catogories_page.dart';
import 'package:freshkart/view/screens/home/home_screen.dart';
import 'package:freshkart/view/screens/account/account_page.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const CatogoriesPage(),

    const CartPage(),
    const AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => callFunction());
  }

  Future<void> callFunction() async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   UserServices.currentUser = UserModel(
    //     email: user.email ?? '',
    //     name: user.displayName ?? '',
    //     uid: user.uid,
    //   );
    // }

    final productProvider = context.read<ProductProvider>();
    productProvider.getAllProducts();
    await productProvider.getOfferProducts();
    await context.read<CategoryProvider>().getCategories();
    await context.read<WshlistProvider>().getWishlistProducts(
      UserServices.currentUser?.uid ??
          FirebaseAuth.instance.currentUser?.uid ??
          '',
      productProvider.allProducts,
    );
    await context.read<CartProvider>().getCartItems();
    await context.read<NotificationProvider>().getAllNotifications();
  }

  void navigateToHome() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(132, 0, 0, 0),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                Consumer<CartProvider>(
                  builder: (context, value, child) {
                    int itemCount = value.cartItems.length;
                    return itemCount > 0
                        ? Positioned(
                          top: -4,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Text(
                              itemCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
