import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piggy/screens/piggy_list.dart';

import 'home_screen.dart';
import 'piggy_list.dart'; // Import the PiggyListScreen

class ManagePiggyScreen extends StatefulWidget {
  final int piggyId;

  const ManagePiggyScreen({super.key, required this.piggyId});

  @override
  State<ManagePiggyScreen> createState() => _ManagePiggyScreenState();
}

class _ManagePiggyScreenState extends State<ManagePiggyScreen> {
  late String userName = '';
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
      DataSnapshot piggySnapshot = await piggyRef.get();
      if (piggySnapshot.exists) {
        final piggys = piggySnapshot.value as Map<dynamic, dynamic>;

        final piggyKey = piggys.keys.firstWhere((key) => piggys[key]['id'] == widget.piggyId);
        final piggy = piggys[piggyKey];

        setState(() {
          isFixed = piggy['fixed'] as bool;
          piggyName = piggy['name'] as String;
          time = piggy['time'] as int;
          total = piggy['needToSave'] as int;
          saved = piggy['saved'] as int;
          fixedValue = (total / time).floor();
          _amountController.text = fixedValue.toString();
          _percent = (saved / total * 100).toDouble();
        });

      } else {
        print('Piggy data not found.');
      }
    } catch (e) {
      print('Error fetching piggy data: $e');
    }
  }

  Future<void> _deletePiggy() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
    final DatabaseReference piggyRef = userRef.child('piggys');

    try {
      DataSnapshot piggySnapshot = await piggyRef.get();
      if (piggySnapshot.exists) {
        final piggys = piggySnapshot.value as Map<dynamic, dynamic>;

        final piggyKey = piggys.keys.firstWhere((key) => piggys[key]['id'] == widget.piggyId);

        await piggyRef.child(piggyKey).remove();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PiggyListScreen()), // Navigate to PiggyListScreen
        );
      } else {
        print('Piggy data not found.');
      }
    } catch (e) {
      print('Error deleting piggy: $e');
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
                          'You have reached ${_percent.toStringAsFixed(2)}% of your Piggy.',
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
              'You have saved $saved from $total in the piggy $piggyName',
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
                  onPressed: () async {
                    try {
                      final User user = FirebaseAuth.instance.currentUser!;
                      final DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
                      final DatabaseReference piggyRef = userRef.child('piggys');

                      DataSnapshot piggySnapshot = await piggyRef.get();
                      if (piggySnapshot.exists) {
                        final piggys = piggySnapshot.value as Map<dynamic, dynamic>;

                        final piggyKey = piggys.keys.firstWhere((key) => piggys[key]['id'] == widget.piggyId);
                        final piggy = piggys[piggyKey];

                        int depositAmount = int.parse(_amountController.text);
                        int newSavedValue = (piggy['saved'] as int) + depositAmount;

                        await piggyRef.child(piggyKey).update({
                          'saved': newSavedValue,
                        });

                        setState(() {
                          saved = newSavedValue;
                          _percent = (saved / total * 100).toDouble();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Deposit successful! New saved value: $newSavedValue'),
                        ));
                      } else {
                        print('Piggy data not found.');
                      }
                    } catch (e) {
                      print('Error updating saved value: $e');
                    }
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
            SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () async {
                await _deletePiggy();
                Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => PiggyListScreen()),
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
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
