// import 'package:flutter/material.dart';
// import 'package:second_project/models/category_model.dart';

// class CategoryOption extends StatelessWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const CategoryOption({
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.teal : Colors.teal.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
//         ),
//       ),

//     );
 
//   }
// }

// class PetCategorycard extends StatelessWidget{
//   final PetCategory category;
//   PetCategorycard({required this.category,Key?key}):super(key: key){
    
//   }
  
//   @override
//   Widget build(BuildContext context) {
//    return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),

//     ),
//     elevation: 3,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: ClipRRect(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                child: Image.network(
//                 category.imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                ),
//           )
//           ),
//           Padding(
//             padding: EdgeInsets.all(9.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(category.breedName,
//                 style: TextStyle(fontSize: 16,
//                 fontWeight: FontWeight.bold,

//                 ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       category.type,
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         // Handle wishlist toggle
//                       },
//                       icon: Icon(
//                         Icons.favorite_border,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: (){

//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text('Add to Cart')
//                     ),
//                 )
//               ],
//             ),
//             )
//       ],
//     ),
//    );
//   }
// }