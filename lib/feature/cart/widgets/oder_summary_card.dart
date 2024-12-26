import 'package:flutter/material.dart';
import '../../../helper/currency_format.dart';


class PaymentSummary extends StatelessWidget {
  final double totalProductPrice;
  final double handlingFee;
  final double shippingFee;
  final double totalPayment;

  const PaymentSummary({
    super.key,
    required this.totalProductPrice,
    required this.handlingFee,
    required this.shippingFee,
    required this.totalPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Harga Produk', totalProductPrice),
          const SizedBox(height: 10),
          _buildSummaryRow('Biaya Penanganan', handlingFee),
          const SizedBox(height: 10),
          _buildSummaryRow('Biaya Pengiriman', shippingFee),
          const Divider(),
          _buildSummaryRow('Total pembayaran', totalPayment, isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          CurrencyFormat.convertToIdr(value, 0), // Format value
          style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
