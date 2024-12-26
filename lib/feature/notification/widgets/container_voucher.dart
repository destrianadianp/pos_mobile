import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/typography.dart';

import '../../ui/dimension.dart';

class ContainerVoucher extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final bool isReaded;
  
  const ContainerVoucher({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.isReaded
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: space500, vertical: space400),
      decoration: BoxDecoration(
        color: isReaded ? secondaryColor : orange50,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey, // Ganti warna border sesuai kebutuhan
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.notifications, size: 20, color: iconNeutralPrimary),
                  const SizedBox(width: space400),
                  Text(
                    title,
                    style: sMedium.copyWith(color: textNeutralPrimary)
                  ),
                ],
              ),
              Text(
                date,
                style: xsMedium,
              ),
            ],
          ),
          const SizedBox(height: space200),
          Text(
            desc,
            style: xsMedium.copyWith(color: black500),
            maxLines: null, // memungkinkan teks membungkus ke baris berikutnya tanpa batas
          ),
        ],
      ),
    );
  }
}
