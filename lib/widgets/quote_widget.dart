import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child:Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("\"The only source of knowledge is experience, you need experience to gain wisdom\"",
              style: TextStyle(
                  fontStyle: FontStyle.italic
              ),),
            Text("Albert Einstein")
          ],
        ),
      ),
    );
  }
}
