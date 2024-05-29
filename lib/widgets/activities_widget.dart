import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Activitieswidget extends ConsumerStatefulWidget {
  final String screenTitle;
  const Activitieswidget({super.key,required this.screenTitle});

  @override
  ConsumerState createState() => _ActivitieswidgetState();
}

class _ActivitieswidgetState extends ConsumerState<Activitieswidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}