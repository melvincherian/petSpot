import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_project/models/breed_model.dart';

class BreedDetails extends StatelessWidget {
  final String breedId;
  const BreedDetails({super.key,required this.breedId});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('breed').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No breeds available'));
            }

            final breed = snapshot.data!.docs.map((doc) {
              return BreedModel.fromMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );
            }).toList();

            return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                itemCount: breed.length,
                itemBuilder: (context, index) {
                  final breeds = breed[index];

                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        leading: breeds.imageUrls.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  breeds.imageUrls.first,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return CircularProgressIndicator(
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded /
                                              (progress.expectedTotalBytes ?? 1)
                                          : null,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                        title: Text(
                          breeds.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (breeds.name.isNotEmpty)
                            //   Text(
                            //     'breed: ${breeds.name}',
                            //     style: const TextStyle(
                            //         fontSize: 14, color: Colors.black54),
                            //   ),
                                if (breeds.category.isNotEmpty)
                              Text(
                                'Category: ${breeds.category}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            // if (breeds.descriptions.isNotEmpty)
                            //   Text(
                            //     'Description: ${breeds.descriptions}',
                            //     style: const TextStyle(
                            //         fontSize: 14, color: Colors.black54),
                            //     maxLines: 2,
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // if (breeds.stock.isNotEmpty)
                            //   Text(
                            //     'Size: ${breeds.size}',
                            //     style: const TextStyle(
                            //         fontSize: 14, color: Colors.black54),
                            //   ),
                            // Text(
                            //   'Stock: ${breeds.careRequirements}',
                            //   style: const TextStyle(
                            //       fontSize: 14, color: Colors.black54),
                            // ),
                            Text(
                              'Price: \$${breeds.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  );
                });
          }),
    );
  }
}