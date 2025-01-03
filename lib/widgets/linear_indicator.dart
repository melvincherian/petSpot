import 'package:flutter/material.dart';

class TRatingprogressIndicator extends StatelessWidget {
  const TRatingprogressIndicator({
    super.key,
    required this.text,
    required this.values,
  });

  final String text;
  final double values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(7),
            value: values,
            minHeight: 11,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ],
    );
  }
}