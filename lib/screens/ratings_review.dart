// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:second_project/screens/review_screen.dart';
import 'package:second_project/widgets/linear_indicator.dart';

class Reviewscreen extends StatefulWidget {
  const Reviewscreen({super.key});

  @override
  _ReviewscreenState createState() => _ReviewscreenState();
}

class _ReviewscreenState extends State<Reviewscreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reviewaddingscreen()));
                      },
                      child: Text(
                        'Write a review',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
