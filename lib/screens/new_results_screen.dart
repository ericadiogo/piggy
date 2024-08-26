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
  int _months = 0;
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
    final DatabaseReference dbRef =
    FirebaseDatabase.instance.ref().child('users/${user.uid}/piggys');

    DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      final piggys = snapshot.value as Map<dynamic, dynamic>;
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

  void _changeMonths(int months) {
    setState(() {
      _months += months;
      if (_months < 1) {
        _months = 0;
      }
    });
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        'Goal',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                      Text(
                        '\$ $_goal',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  flex: 6,
                  child: Slider(
                    value: _currentSliderValue,
                    max: 100000,
                    divisions: 50000,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey[500],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '\$ $_currentSliderValue',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Lilita One',
                    ),
                  ),
                ),
              ],
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
