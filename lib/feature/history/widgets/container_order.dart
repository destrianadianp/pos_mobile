import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/typography.dart';
import 'package:pos_mobile/helper/currency_format.dart';

class OrderCard extends StatelessWidget {
  final String date;
  final String address;
  final double price;

  const OrderCard({
    super.key,
    required this.date,
    required this.address,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String formattedPrice = CurrencyFormat.convertToIdr(price, 0);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: smRegular.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Image.asset('assets/images/take away.png'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: smRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                "Pesanan selesai",
                style: smRegular.copyWith(color: Colors.green),
              ),
              const Spacer(),
              Text(
                formattedPrice,
                style: smRegular.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
