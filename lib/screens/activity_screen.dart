import 'package:flutter/cupertino.dart';
import 'package:studypal/widgets/app_bar_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(appBarTitile: "Activities")
      ],
    );
  }
}
