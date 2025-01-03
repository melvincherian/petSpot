import 'package:flutter/material.dart';
import 'package:second_project/widgets/linear_indicator.dart';

class Reviewscreen extends StatelessWidget {
  const Reviewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ratings and reviews are verified and are from people who use the same type of device that you use',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '4.8',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        TRatingprogressIndicator(text: '5', values: 1.0),
                        SizedBox(height: 4),
                        TRatingprogressIndicator(text: '4', values: 0.8),
                        SizedBox(height: 4),
                        TRatingprogressIndicator(text: '3', values: 0.6),
                        SizedBox(height: 4),
                        TRatingprogressIndicator(text: '2', values: 0.4),
                        SizedBox(height: 4),
                        TRatingprogressIndicator(text: '1', values: 0.2),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


