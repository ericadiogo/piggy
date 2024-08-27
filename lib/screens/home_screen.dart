import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'profile_screen.dart';
import 'results_screen.dart';
import 'conversion_screen.dart';
import 'new_piggy.dart';
import 'piggy_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userName = '';
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
      final DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        final userData = snapshot.value as Map?;
        setState(() {
          userName = userData?['name'] ?? 'User';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: Container(
        padding: EdgeInsets.all(40),
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hey, $userName!',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Image.asset('assets/images/piggy_coins_glasses.png', width: 150),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPiggyScreen(),),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('New Piggy',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PiggyListScreen(),),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('My Piggys',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConversionScreen(),),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('Conversion',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(),),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
