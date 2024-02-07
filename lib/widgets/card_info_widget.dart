import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInfoWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function() doThis;

  const CardInfoWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.doThis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: doThis,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          child: Column(
            children: [
              icon,
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
