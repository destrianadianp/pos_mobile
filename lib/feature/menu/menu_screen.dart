import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../ui/color.dart';
import '../ui/dimension.dart';
import 'widgets/menu_card.dart';

class MenuScreen extends StatefulWidget {
  final String userId;

  const MenuScreen({
    super.key,
    required this.userId,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Use context.read to get the provider instance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().fetchProducts(widget.userId);
    });
  }

  /* Future<List<ProductModel>> _fetchProductsByUserId() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('userId', isEqualTo: widget.userId)
          .get();

      return querySnapshot.docs.map(
        (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
          final Map<String, dynamic> data = doc.data();
          return ProductModel(
            productId: doc.id,
            productName: data['productName'],
            productImage: data['productImage'],
            price: data['price'],
            category: data['category'],
            userId: data['userId'],
          );
        },
      ).toList();
    } catch (e) {
      return [];
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: secondaryColor,
            body: Padding(
              padding: const EdgeInsets.all(screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Destriana",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                          if (cart.cartItems.isNotEmpty)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${cart.cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Daftar produk
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) {
                        final product = cart.products[index];
                        final isInCart = cart.cartItems.any(
                          (item) {
                            return item.product.productId == product.productId;
                          },
                        );
                        return ProductCard(
                          product: product,
                          isInCart: isInCart,
                          cartProvider: cart,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
