import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';

class CustomContainerOutlined extends StatelessWidget {
  final String image;
  final Color borderColor;
  final String label;
  final VoidCallback onTap;

  const CustomContainerOutlined({
    super.key,
    required this.image,
    this.borderColor = Colors.grey,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
      padding: const EdgeInsets.all(8), // Adjusted padding for image fitting
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Image.asset(
        image,
        width: 60, // Setting image dimensions as per your requirement
        height: 60,
      ),
        ),
        const SizedBox(height: space200,),
        Text(label)
      ],
      
    );

  }
}