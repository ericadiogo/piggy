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
    final DatabaseReference userRef = FirebaseDatabase.instance.ref().child(
        'users/${user.uid}');
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
        print('Piggy data: $piggys');

        final highestId = piggys.values
            .map((piggy) => piggy['id'] as int)
            .reduce((value, element) => value > element ? value : element);

        final highestPiggy = piggys.values
            .firstWhere((piggy) => piggy['id'] == highestId);

        print('Highest Piggy: $highestPiggy');

        setState(() {
          isFixed = highestPiggy['fixed'] as bool;
          piggyName = highestPiggy['name'] as String;
          time = highestPiggy['time'] as int;
          total = highestPiggy['needToSave'] as int;
          saved = highestPiggy['saved'] as int;
          fixedValue = (total / time).floor();

          // Calculate percentage
          _percent = (saved / total * 100).toDouble();
        });

        print(
            'State updated: $piggyName, $total, $saved, $fixedValue, $_percent'); // Debug statement
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        SizedBox(height: 10,),
                        Text(
                          'You have reached ${_percent.toStringAsFixed(
                              2)}% of your Piggy.',
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
            SizedBox(height: 150),
            Text(
              'You have saved $saved out of $total for the $piggyName Piggy',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Monthly recommended deposit: " +
                    fixedValue.toString(),
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
                  onPressed: () async {
                    try {
                      final User user = FirebaseAuth.instance.currentUser!;
                      final DatabaseReference userRef = FirebaseDatabase
                          .instance.ref().child('users/${user.uid}');
                      final DatabaseReference piggyRef = userRef.child(
                          'piggys');

                      DataSnapshot piggySnapshot = await piggyRef.get();
                      if (piggySnapshot.exists) {
                        final piggys = piggySnapshot.value as Map<
                            dynamic,
                            dynamic>;

                        final highestId = piggys.values
                            .map((piggy) => piggy['id'] as int)
                            .reduce((value, element) =>
                        value > element
                            ? value
                            : element);

                        final highestPiggyKey = piggys.keys.firstWhere((
                            key) => piggys[key]['id'] == highestId);
                        final highestPiggy = piggys[highestPiggyKey];

                        int depositAmount = int.parse(_amountController.text);
                        int newSavedValue = (highestPiggy['saved'] as int) +
                            depositAmount;

                        await piggyRef.child(highestPiggyKey).update({
                          'saved': newSavedValue,
                        });

                        setState(() {
                          saved = newSavedValue;
                          _percent = (saved / total * 100)
                              .toDouble();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Deposit successful! New saved value: $newSavedValue'),
                        ));
                      } else {
                        print('Piggy data not found.');
                      }
                    } catch (e) {
                      print('Error updating saved value: $e');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(150.0, 60.0)),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(10)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(150.0, 60.0)),
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