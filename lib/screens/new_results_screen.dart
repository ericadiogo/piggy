import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';

class NewResultsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewResultsScreenState();
}

class _NewResultsScreenState extends State<NewResultsScreen> {
  late String userName = '';
  late String goal = '';
  late String piggyName = 'Hello';
  double _percent = 0;
  bool isFixed = true;
  int time = 8;
  int total = 50;
  int fixedValue = 100;
  int saved = 3;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPiggyData();
  }

  Future<void> _fetchPiggyData() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
    final DatabaseReference piggyRef = userRef.child('piggys');

    try {

      DataSnapshot userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.value as Map<dynamic, dynamic>;
        print('User data: $userData');
        setState(() {
          userName = userData['name'] as String;
        });
      } else {
        print('User data not found.');
      }

      DataSnapshot piggySnapshot = await piggyRef.get();
      if (piggySnapshot.exists) {
        final piggys = piggySnapshot.value as Map<dynamic, dynamic>;
        print('Piggy data: $piggys'); // Debug statement

        final highestId = piggys.values
            .map((piggy) => piggy['id'] as int)
            .reduce((value, element) => value > element ? value : element);

        final highestPiggy = piggys.values
            .firstWhere((piggy) => piggy['id'] == highestId);

        print('Highest Piggy: $highestPiggy'); // Debug statement

        setState(() {
          isFixed = highestPiggy['fixed'] as bool;
          piggyName = highestPiggy['name'] as String;
          time = highestPiggy['time'] as int;
          total = highestPiggy['needToSave'] as int;
          saved = highestPiggy['saved'] as int;
          fixedValue = (total / time).floor();
          _amountController.text = fixedValue.toString();
        });

        print('State updated: $piggyName, $total, $saved, $fixedValue'); // Debug statement
      } else {
        print('Piggy data not found.');
      }
    } catch (e) {
      print('Error fetching piggy data: $e');
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
            Text(
              'You have saved $saved from $total  in the piggy $piggyName',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Monthly recommended deposit: " + fixedValue.toString(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add deposit logic here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                  ),
                  child: Text(
                    'Deposit',
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
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                  ),
                  child: Text(
                    'Return',
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