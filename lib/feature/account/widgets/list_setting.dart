import 'package:flutter/material.dart';

class ListSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;


  const ListSetting({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}