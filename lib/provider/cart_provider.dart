import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<ProductModel> _products = [];
  final List<CartModel> _cartItems = [];

  List<ProductModel> get products => _products;
  List<CartModel> get cartItems => _cartItems;

  // Fetch products by userId
  Future<void> fetchProducts(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('userId', isEqualTo: userId)
          .get();

      _products.clear();
      _products.addAll(snapshot.docs.map((doc) {
        final data = doc.data();

        return ProductModel(
          productId: doc.id,
          productName: data['productName'] ?? '',
          productImage: data['productImage'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          category: data['category'] ?? '',
          userId: data['userId'] ?? '',
        );
      }).toList());

      for (final item in _products) {
        debugPrint("Product ${item.toString()}");
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }
  }

  // Add product to cart
  Future<void> addToCart(String productId) async {
    try {
      // Cari produk berdasarkan productId
      final product =
          _products.firstWhereOrNull((item) => item.productId == productId);

      if (product == null) {
        // Jika produk tidak ditemukan
        debugPrint("Product with ID $productId not found");
        return;
      }

      // Cek apakah produk sudah ada di keranjang
      final existingCartItem = _cartItems.firstWhereOrNull(
          (cartItem) => cartItem.product.productId == productId);

      if (existingCartItem != null) {
        // Jika produk sudah ada, tambahkan jumlahnya
        existingCartItem.quantity += 1;
      } else {
        // Jika produk belum ada, tambahkan ke keranjang
        _cartItems.add(CartModel(product: product, quantity: 1));
      }

      // Notifikasi perubahan pada UI
      notifyListeners();
    } catch (e, stackTrace) {
      // Tangani kesalahan yang tidak terduga
      debugPrint("Error adding to cart: $e");
      debugPrint("Stack Trace: $stackTrace");
    }
  }

  void remove(CartModel item) {
    final removedItem = _cartItems.firstWhereOrNull(
        (cartItem) => cartItem.product.productId == item.product.productId);

    if (removedItem != null) {
      _cartItems.remove(removedItem);
      notifyListeners();
    } else {
      debugPrint("Item not found in cart: ${item.product.productId}");
    }
  }

  void addQuantity(String productId) {
    final cartItem = _cartItems.firstWhereOrNull(
        (cartItem) => cartItem.product.productId == productId);

    if (cartItem != null) {
      cartItem.quantity += 1;
      notifyListeners();
    } else {
      debugPrint("Cart item not found for product ID: $productId");
    }
  }

  void minusQuantity(String productId) {
    final cartItem = _cartItems.firstWhereOrNull(
        (cartItem) => cartItem.product.productId == productId);

    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        cartItem.quantity -= 1;
      } else {
        _cartItems.remove(cartItem);
      }
      notifyListeners();
    } else {
      debugPrint("Cart item not found for product ID: $productId");
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
