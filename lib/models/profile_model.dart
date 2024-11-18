class Profilemodel{

final String image;
final String username;
final String phonenumber;

Profilemodel({
  required this.image,
  required this.username,
  required this.phonenumber
});

factory Profilemodel.fromMap(Map<String,dynamic>map){
  return Profilemodel(
    image: map['image'], 
    username: map['username'], 
    phonenumber: map['phonenumber']
    );
}

Map<String,dynamic>toMap(){
  return {
    'image':image,
    'username':username,
    'phonenumber':phonenumber
  };
}


}