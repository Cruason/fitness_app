import 'package:fitness_app/core/constants/constants.dart';
import 'package:fitness_app/features/original/di/injection_container.dart';
import 'package:fitness_app/features/original/domain/service/firebase_auth_service.dart';
import 'package:fitness_app/features/original/presentation/pages/auth/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool isLoginSelected;
  User? user;
  final FirebaseAuthService _authService = di();

  @override
  void initState() {
    user = _authService.getCurrentUser();
    isLoginSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (user != null)
            ? Text("Profile Page")
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: (isLoginSelected)
                                ? CustomColors.orangeF08700.color
                                : Colors.black),
                      ),
                      onTap: () => setState(() {
                            isLoginSelected = true;
                          })),
                  InkWell(
                      child: Text("Register",
                          style: TextStyle(
                              color: (!isLoginSelected)
                                  ? CustomColors.orangeF08700.color
                                  : Colors.black)),
                      onTap: () => setState(() {
                            isLoginSelected = false;
                          })),
                ],
              ),
        (user != null)
            ? ProfilePage(
                user: user,
                onClick: () async{
                  await _authService.signOut();
                  final us = _authService.getCurrentUser();
                  setState(() {
                    user = us;
                  });
                } ,
              )
            : (isLoginSelected)
                ? LoginPage(
                    onClick: (email, password) async {
                      final us = await _authService.signInWithEmailAndPassword(
                        email,
                        password,
                      );
                      setState(() {
                        user = us;
                      });
                    },
                  )
                : RegistrationPage(
                    onClick: (email, password) async {
                      final us = await _authService.signUpWithEmailAndPassword(
                        email,
                        password,
                      );
                      setState(() {
                        user = us;
                      });
                    },
                  )
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  final Function onClick;

  const LoginPage({super.key, required this.onClick});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onClick(_emailController.text, _passwordController.text);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  final Function onClick;

  const RegistrationPage({super.key, required this.onClick});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onClick(_emailController.text, _passwordController.text);
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
