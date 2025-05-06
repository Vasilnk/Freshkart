import 'package:flutter/material.dart';
import 'package:freshkart/view/widgets/tiles/toast_tile.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class WishlistIconButton extends StatelessWidget {
  final bool isFavorite;
  final WshlistProvider value;
  final String name;
  const WishlistIconButton({
    super.key,
    required this.isFavorite,
    required this.value,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isFavorite) {
          value.removeFavorite(name, UserServices.currentUser!.uid, context);
          showToast('$name removed from wishlist', false);
        } else {
          value.addFavorite(name, UserServices.currentUser!.uid);
          showToast('$name added to wishlist');
        }
      },
      icon: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        size: 30,
        color:
            isFavorite ? const Color.fromARGB(255, 231, 113, 105) : Colors.grey,
      ),
    );
  }
}
