// class AccessoryModel {
//   final String accesoryname;
//   final double price;
//   final String? image; // Single image URL

//   AccessoryModel({
//     required this.accesoryname,
//     required this.price,
//     this.image,
//   });

//   factory AccessoryModel.fromJson(Map<String, dynamic> json) {
//     return AccessoryModel(
//       accesoryname: json['accesoryname'],
//       price: json['price'],
//       image: json['image'], // Ensure this matches the Firestore field
//     );
//   }
// }
