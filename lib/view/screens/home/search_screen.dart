import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/constants.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view_model/services/search_products_services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  SearchProductsServices services = SearchProductsServices();
  int? count;

  @override
  void initState() {
    allProducts = context.read<ProductProvider>().allProducts;
    filteredProducts = allProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Column(
            spacing: 10,
            children: [
              const SizedBox(height: 20),
              Row(
                spacing: 5,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: searchController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 13),
                          border: InputBorder.none,
                          hintText: 'Search Products',
                          prefixIcon: Icon(Icons.search),

                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (query) {
                          final filtered = services.searchFilterProducts(
                            query,
                            allProducts,
                          );
                          setState(() {
                            query.isNotEmpty
                                ? count = filtered.length
                                : count = null;
                            filteredProducts = filtered;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showMenu<String>(
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 100, 20, 0),
                        items: Constants.popupMenus,
                      ).then((selected) {
                        fetchByCategory(selected);
                      });
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    count == null
                        ? const SizedBox.shrink()
                        : Text(
                          '     Search result (${filteredProducts.length} items)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                    filteredProducts.isEmpty
                        ? const Center(
                          child: Text('No products Availabel now '),
                        )
                        : Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductCard(product: product),
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fetchByCategory(selected) {
    if (selected == 'all') {
      setState(() {
        filteredProducts = allProducts;
      });
    } else if (selected == 'discount') {
      final filtered = allProducts.where((product) => product.offer).toList();

      setState(() {
        filteredProducts = filtered;
      });
    } else if (selected == 'lowToHigh') {
      final products = List<ProductModel>.from(allProducts);
      products.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
      setState(() {
        filteredProducts = products;
      });
    } else if (selected == 'highToLow') {
      final products = List<ProductModel>.from(allProducts)
        ..sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
      setState(() {
        filteredProducts = products;
      });
    }
  }
}
