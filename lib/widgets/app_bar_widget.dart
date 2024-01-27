import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String appBarTitile;
  const AppBarWidget({super.key, required this.appBarTitile});

  @override
  Widget build(BuildContext context) {
    return   PreferredSize(preferredSize: const Size.fromHeight(50), child: AppBar(
      title: Text(appBarTitile),

    ));
  }
}
