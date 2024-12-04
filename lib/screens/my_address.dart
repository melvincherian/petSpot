import 'package:flutter/material.dart';
import 'package:second_project/screens/add_address.dart';

class Myaddress extends StatelessWidget {
  const Myaddress({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('My Address',
        
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold
        ),
        
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          
          IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.blue,)),
         TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress()));
         }, child: Text('Add new address',
         style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),
         ))
          // SizedBox(width: 250),
          // IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
    
    );
  }
}