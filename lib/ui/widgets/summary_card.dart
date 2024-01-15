import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.number, required this.title,
  });

  final  int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$number',style: TextStyle(fontWeight: FontWeight.w600),),
              Text('$title',style: TextStyle(fontSize: 13),)
            ],
          ),
        ),
      ),
    );
  }
}
