class SignupUsermodel{
  final String?name;
  final String?email;
  final String?password;

  SignupUsermodel({
    required this.name,
    required this.email,
    required this.password
  });

factory SignupUsermodel.fromMap(Map<String,dynamic>map){
  return SignupUsermodel(
    name: map['name'], 
    email: map['email'], 
    password: map['password']
    );
}

Map<String,dynamic>toMap(){
  return {
    'name':name,
    'email':email,
    'password':password
  };
}

}