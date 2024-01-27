import 'package:flutter/cupertino.dart';

import '../widgets/app_bar_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
        AppBarWidget(appBarTitile: "Settings")
      ],
    );
  }
}
