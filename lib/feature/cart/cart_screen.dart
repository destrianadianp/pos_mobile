import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/feature/ui/shared_view/custom_button.dart';
import 'package:pos_mobile/feature/ui/typography.dart';
import 'package:provider/provider.dart';
import '../../helper/currency_format.dart';
import '../../provider/cart_provider.dart';
import '../../provider/transaction_provider.dart';
import 'widgets/cart_container.dart';
import 'widgets/location_selector.dart';
import 'widgets/oder_summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? location;
  double? latitude;
  double? longitude;
  String selectedPaymentMethod = 'COD';

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        double totalProductPrice = cart.cartItems.fold(0.0, (sum, item) {
          final price = item.product.price ?? 0;
          final quantity = item.quantity ?? 1;
          return sum + (price * quantity);
        });

        double handlingFee = 3000;
        double shippingFee = 15000;
        double totalPayment = totalProductPrice + handlingFee + shippingFee;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: secondaryColor,
            leading: GestureDetector(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  )),
            ),
            title: const Text(
              "Cart Screen",
              style: mRegular,
            ),
            shape: const Border(bottom: BorderSide(color: borderTransparent)),
          ),
          backgroundColor: secondaryColor,
          body: cart.cartItems.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProductListView(),
                            const SizedBox(height: 5),
                            LocationSelector(
                              onLocationSelected: (address, lat, lng) {
                                setState(() {
                                  location = address;
                                  latitude = lat;
                                  longitude = lng;
                                });
                              },
                            ),
                            const SizedBox(height: space800),
                            const Text('Ringkasan pembayaran'),
                            const SizedBox(height: 10),
                            PaymentSummary(
                              totalProductPrice: totalProductPrice,
                              handlingFee: handlingFee,
                              shippingFee: shippingFee,
                              totalPayment: totalPayment,
                            ),
                            const SizedBox(height: 20),
                            _buildPaymentMethod()
                          ],
                        ),
                      ),
                    ),
                    _buildBottomBar(totalPayment),
                  ],
                )
              : Center(
                  child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ayam.png',
                      width: 300,
                      height: 300,
                    ),
                    const Text("Your Cart is Empty!"),
                  ],
                )),
        );
      },
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      children: [
        // Opsi Cash On Delivery
        ListTile(
          leading: const Icon(Icons.money, color: Colors.green),
          title: const Text("Cash On Delivery"),
          trailing: Radio<String>(
            value: 'COD',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value!;
              });
            },
          ),
        ),
        // Opsi Online Credit/Debit
        ListTile(
          leading: const Icon(Icons.credit_card, color: Colors.blue),
          title: const Text("Online Credit/Debit"),
          trailing: Radio<String>(
            value: 'Online',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(double totalPayment) {
    return Container(
      color: secondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Pembayaran:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Rp ${totalPayment.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: () {
              // Mengakses instance CartProvider
              final cart = Provider.of<CartProvider>(context, listen: false);

              // Menambahkan transaksi ke TransactionProvider
              final transactionProvider =
                  Provider.of<TransactionProvider>(context, listen: false);
              final String currentDate =
                  DateTime.now().toLocal().toString().substring(0, 16);

              transactionProvider.addTransaction(
                Transaction(
                  date: currentDate,
                  address: location ?? 'Alamat tidak dipilih',
                  totalPrice: totalPayment,
                ),
              );

              // Kosongkan keranjang setelah pemesanan
              cart.clearCart();

              // Tampilkan pesan sukses
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Pesanan berhasil dibuat!")),
              );

              // Navigasi kembali
              Navigator.pop(context);
            },
            child: const Text('Pesan Sekarang'),
          ),
        ],
      ),
    );
  }
}
