class AddressModel {
  final String?id;
  final String name;
  final int phone;
  final int pincode;
  final String state;
  final String city;
  final String buildingName;
  final String roadName;
  final String location;

  AddressModel({
    this.id,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.state,
    required this.city,
    required this.buildingName,
    required this.roadName,
    required this.location
  });

  // Factory constructor to create an AddressModel from a JSON map
  factory AddressModel.fromMap(Map<String, dynamic> map,String id) {
    return AddressModel(
      id: map['id'],
      name: map['name'] as String,
      phone: map['phone'] as int,
      pincode: map['pincode'] as int,
      state: map['state'] as String,
      city: map['city'] as String,
      buildingName: map['buildingName'] as String,
      roadName: map['roadName'] as String,
      location: map['location']as String,
    );
  }

  // Method to convert an AddressModel to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'phone': phone,
      'pincode': pincode,
      'state': state,
      'city': city,
      'buildingName': buildingName,
      'roadName': roadName,
      'location':location,
    };
  }
}
