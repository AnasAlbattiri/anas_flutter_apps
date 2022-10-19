import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final bool isMale;
  final int result;
  final int age;

  BMIResultScreen({
    required this.age,
    required this.result,
    required this.isMale,
});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'BMI Result',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text(
              'Gender : ${isMale ? 'Male' : 'Female'}',
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
              ),
            ),
            Text(
              'Result : $result',
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
              ),
            ),
            Text(
              'Age : $age',
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
              ),
            ),

          ],
        ),
      ),

    );
  }
}
