// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/otp_screen.dart';
import 'package:second_project/widgets/signup_textfield.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final usernameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmpassController=TextEditingController();

   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration:const BoxDecoration(
                image: DecorationImage(image:
                NetworkImage('https://img.freepik.com/free-photo/flat-lay-toys-with-food-bowl-fur-brush-dogs_23-2148949620.jpg'),
                fit: BoxFit.cover,
        
                )
              ),
            ),
            Container(
                decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
                ),
            ),
            Center(
              child: Container(
                  child: SingleChildScrollView(
                    padding:const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                     const   Text('Create Account',
                        style: TextStyle(fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        ),
                        SignupTextFormField(
                          labelText: 'Username', 
                          hintText: 'Username', 
                          prefixIcon:const Icon(Icons.person), 
                          controller: usernameController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Please Enter username';
                            }
                            else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                      return 'Username can only contain letters, digits, and underscores';
                        
                          }
                          return null;
                          }
                          
                          ),
                       const   SizedBox(height: 10),
                           SignupTextFormField(
                          labelText: 'Email', 
                          hintText: 'Email', 
                          prefixIcon:const Icon(Icons.email), 
                          controller: emailController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Please Enter Email';
                            }
                             else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                             return 'Please enter a valid email';
                      }
                            return null;
                          },
                          
                          ),
                         const  SizedBox(height: 10),
                           SignupTextFormField(
                          labelText: 'Password', 
                          hintText: 'Password', 
                          obscureText: true,
                          prefixIcon:const Icon(Icons.lock), 
                          controller: passwordController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Please Enter Password';
                            }
                            else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
                          
                            }
                            return null;
                          },
                          
                          ),
                        const   SizedBox(height: 10),
                           SignupTextFormField(
                          labelText: 'Confirm Password', 
                          hintText: 'Re-Enter your password', 
                          obscureText: true,
                          prefixIcon:const Icon(Icons.lock_outline), 
                          controller: confirmpassController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Please Enter Confirmpassword';
                            }
                              else if (value.length < 8) {
                             return 'Password must be at least 8 characters long';
                          
                            }
                            return null;
                          },
                          
                          ),
                        const SizedBox(height: 24.0),
                       ElevatedButton(onPressed: (){
                      
                        Get.to(const ScreenOtp());
                          // if(_formKey.currentState!.validate()){

                          // }
                       }, 
                       style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                       ),
                       child:const Text('Sign Up',
                       style: TextStyle(color: Colors.white),
                       )
                       ),
                    const   SizedBox(height: 16),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const  Text('Already have an account?',
                          style: TextStyle(color: Colors.white),
                          ),
                          TextButton(onPressed: (){
                             
                          }, child:const Text('Login',
                          style: TextStyle(color: Colors.blue),
                          ))
                        ],
                       )
                      ],
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}