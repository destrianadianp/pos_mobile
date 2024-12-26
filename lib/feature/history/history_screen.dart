import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:provider/provider.dart';
import '../../provider/transaction_provider.dart';
import 'widgets/container_order.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Riwayat Pesanan"),
      // ),
      body: transactions.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return OrderCard(
                  date: transaction.date,
                  address: transaction.address,
                  price: transaction.totalPrice,
                );
              },
            )
          : const Center(
              child: Text("Belum ada riwayat pesanan."),
            ),
    );
  }
}
