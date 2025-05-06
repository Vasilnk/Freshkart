import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:go_router/go_router.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Row(
          spacing: 10,
          children: [
            Icon(Icons.search),
            Text('Search Poduct', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      onTap: () => context.push(Routes.search),
    );
  }
}
