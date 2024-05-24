import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatelessWidget {
  final User? user;
  final Function onClick;

  ProfilePage({Key? key, required this.user, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome, ${user?.email}!'),
          SizedBox(height: 16),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
             onClick();
            },
          ),
          // Add other profile information here
        ],
      ),
    );
  }
}
