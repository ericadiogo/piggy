import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:piggy/screens/piggy_from_list.dart';
import 'piggy_from_list.dart';

class PiggyListScreen extends StatefulWidget {
  const PiggyListScreen({super.key});

  @override
  State<PiggyListScreen> createState() => _PiggyListScreenState();
}

class _PiggyListScreenState extends State<PiggyListScreen> {
  late DatabaseReference _piggysRef;
  late User _currentUser;
  List<Map<dynamic, dynamic>> _piggys = [];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _piggysRef = FirebaseDatabase.instance.ref().child('users/${_currentUser.uid}/piggys');
    _fetchPiggys();
  }

  Future<void> _fetchPiggys() async {
    DataSnapshot snapshot = await _piggysRef.get();

    if (snapshot.exists) {
      setState(() {
        final piggysMap = snapshot.value as Map<dynamic, dynamic>;
        _piggys = piggysMap.values.map((piggy) => Map<dynamic, dynamic>.from(piggy)).toList();
      });
    }
  }

  void _navigateToManagePiggyScreen(int piggyId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManagePiggyScreen(piggyId: piggyId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFA3B2),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Piggys',
          style: TextStyle(
            fontFamily: 'Lilita One',
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        width: double.infinity,
        alignment: Alignment.center,
        child: _piggys.isEmpty
            ? const Center(
          child: Text(
            'No piggys found',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        )
            : ListView.builder(
          itemCount: _piggys.length,
          itemBuilder: (context, index) {
            final piggy = _piggys[index];
            return GestureDetector(
              onTap: () => _navigateToManagePiggyScreen(piggy['id']),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      piggy['name'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lilita One',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Need to Save: \$${piggy['needToSave']}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Saved: \$${piggy['saved']}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Time: ${piggy['time']} months',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
