import 'package:flutter/material.dart';
import '../functions/fetchrates.dart';
import '../models/ratesModel.dart';
import '../utils/anytoany.dart';
import 'home_screen.dart';

class ConversionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen>{
  late String userName = '';
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
  String answer = '';

  @override
  void initState(){
    super.initState();
    setState(() {
      result = fetchRates();
      allcurrencies = fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Image.asset('assets/images/currency.png',width: 100),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child:
                      Row(
                        children: [
                          Icon(
                            Icons.currency_exchange,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          SizedBox(width: 10,),
                          Text('Convert any currency:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'Lilita One',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Form(
                key: formKey,
                child: FutureBuilder<RatesModel>(
                    future: result,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(
                        child: FutureBuilder<Map>(
                          future: allcurrencies,
                          builder: (context, currSnapshot){
                            if(currSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnyToAny(
                                  currencies: currSnapshot.data!,
                                  rates: snapshot.data!.rates,
                                ),
                              ],
                            );
                          }),
                      );
                    },
                  ),
              ),
              SizedBox(height: 60,),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen(),),);
              },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                  fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0),),
                ),
                child: Text('Back',
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
      ),
    );
  }
}