import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/ratings_bloc.dart';
import 'package:second_project/models/review_rating_model.dart';
// import 'package:second_project/models/review_rating_model.dart';

class Reviewaddingscreen extends StatefulWidget {
  const Reviewaddingscreen({
    super.key,
  });

  @override
  State<Reviewaddingscreen> createState() => _ReviewaddingscreenState();
}

class _ReviewaddingscreenState extends State<Reviewaddingscreen> {
  final ValueNotifier<int> _selectedRating = ValueNotifier<int>(0);
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _selectedRating.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Review',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: BlocListener<RatingsBloc, RatingsState>(
        listener: (context, state) {
          if (state is RatingsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.green, content: Text(state.message)),
            );
          } else if (state is RatingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade50, Colors.deepPurple.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rate your experience',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<int>(
                    valueListenable: _selectedRating,
                    builder: (context, selectedRating, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              _selectedRating.value = index + 1;
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.star,
                                color: index < selectedRating
                                    ? Colors.yellow
                                    : Colors.grey,
                                size: 35,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your review here...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    controller: _reviewController,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      final reviewItem = ReviewItems(
                        userReference: '',
                        ratings: _selectedRating.value.toDouble(),
                        comments: _reviewController.text,
                        reviewDate: DateTime.now(),
                      );

                      context.read<RatingsBloc>().add(
                            AddreviewEvent(
                              productReference: 'someProductReference',
                              review: reviewItem,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 80.0,
                      ),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
