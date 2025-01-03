// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/screens/user side/forgotpassword/forgotpass_screen.dart';
import 'package:second_project/screens/user side/home_screen.dart';
import 'package:second_project/screens/user side/user authentication/user_signup.dart';
import 'package:second_project/services/shared_pref.dart';
import 'package:second_project/widgets/login_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final googleController=TextEditingController();
   final _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state)async {
          if (state is AuthenticationLoading) {
       
          }
          if (state is AuthenticationSuccess && state.source=='google') {
               await SharedPrefHelper().saveUserGoogle(googleController.text);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenHome()));
          }
           if (state is AuthenticationSuccess && state.source=='login') {
               await SharedPrefHelper().saveUserEmail(emailController.text);
           
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login Successfully",
                style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenHome()));
            
          }
          if (state is AuthenticationFailure && state.source=='login') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Invalid Email and password'),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Image(
                    image: NetworkImage(
                        'https://m.media-amazon.com/images/I/61fJefies-L._AC_SL1200_.jpg'),
                    height: 170,
                    width: 170,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  LoginTextfield(
                    labelText: 'Email',
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  LoginTextfield(
                    labelText: 'Password',
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenForgotpassword()));
                          
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserSignup()));
                         
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _loginUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      elevation: 5,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or Login with',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      _loginWithGoogle();
                    },
                    icon: Image.network(
                      'https://53.fs1.hubspotusercontent-na1.net/hub/53/hubfs/image8-2.jpg?width=595&height=400&name=image8-2.jpg',
                      height: 24,
                      width: 24,
                    ),
                    label: const Text(
                      'Login with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(LoginRequested(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        
        source: 'login'
      ));
 context.read<AuthenticationBloc>().stream.listen((state) async {
      if (state is AuthenticationSuccess) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('userLogged', true);
         print("Login state saved: ${prefs.getBool('userLogged')}"); // Save login status
      }
    });
      
    }
  }

  void _loginWithGoogle() {
    context.read<AuthenticationBloc>().add(GoogleLoginRequested());
  }
}
