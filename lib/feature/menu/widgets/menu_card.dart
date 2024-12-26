import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../models/cart_model.dart';
import '../../../helper/currency_format.dart';
import '../../../models/product_model.dart';
import '../../../provider/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isInCart;
  final CartProvider cartProvider;

  const ProductCard({
    super.key,
    required this.product,
    required this.isInCart,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: product.productImage.isNotEmpty
      ? Image.memory(
          base64Decode(product.productImage),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 80, color: Colors.grey);
          },
        )
      : const Icon(Icons.image, size: 80, color: Colors.grey),
),


            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    CurrencyFormat.convertToIdr(product.price, 0), // Use formatted currency
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isInCart) {
                          cartProvider.remove(CartModel(
                            product: product,
                            quantity: 1,
                          ));
                        } else {
                          cartProvider.addToCart(product.productId);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isInCart ? Colors.red : Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        isInCart ? "Remove" : "Add to cart",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), 
      ),
    );
  }
}
