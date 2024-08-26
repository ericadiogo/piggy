import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'conversion_screen.dart';
import 'home_screen.dart';

class NewResultsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewResultsScreenState();
}

class _NewResultsScreenState extends State<NewResultsScreen> {
  late String userName = '';
  late String goal = '';
  double _percent = 0;
  bool isFixed = true;
  int time = 8;
  double _currentSliderValue = 0;
  double _goal = 0;

  @override
  void initState() {
    super.initState();
    _fetchPiggyData();
  }

  Future<void> _fetchPiggyData() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
    final DatabaseReference piggyRef = userRef.child('piggys');

    DataSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        userName = userData['name'] as String;
      });
    }

    DataSnapshot piggySnapshot = await piggyRef.get();
    if (piggySnapshot.exists) {
      final piggys = piggySnapshot.value as Map<dynamic, dynamic>;
      final highestId = piggys.values
          .map((piggy) => piggy['id'] as int)
          .reduce((value, element) => value > element ? value : element);

      final highestPiggy = piggys.values
          .firstWhere((piggy) => piggy['id'] == highestId);

      setState(() {
        isFixed = highestPiggy['fixed'] as bool;
        time = highestPiggy['time'] as int;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int numCheckboxes = isFixed ? time : 30;
    String checkboxText = isFixed ? '50' : '60';

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      //backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey, $userName!',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Lilita One',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'You reached less than ($_percent)% of your Piggy.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: ListView.builder(
                itemCount: numCheckboxes,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: false,
                        activeColor: Colors.black,
                        onChanged: (bool? newValue) {
                        },
                      ),
                      Text(
                        '\$ $checkboxText',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConversionScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                  ),
                  child: Text(
                    'Conversion',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
