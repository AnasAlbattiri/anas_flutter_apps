import 'dart:math';
import 'package:flutter/material.dart';
import '../bmi_result/bmi_result_screen.dart';

class BMIScreen extends StatefulWidget {


  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  bool isMale = true;
  double height = 120.0;
  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children:
        [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState (()
                        {
                          isMale = true;
                        }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMale ? Colors.teal : Colors.grey,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          )
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Image(
                                image: AssetImage('Assets/Images/Male.png'),
                              width: 90.0,
                              height: 90.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState (()
                        {
                          isMale = false;
                        }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: !isMale ? Colors.pink : Colors.grey,
                            borderRadius: BorderRadius.circular(
                              10.0,
                            )
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Image(
                                image: AssetImage('Assets/Images/Female.png'),
                                width: 90.0,
                                height: 90.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0 ,
                        ),
                        Text(
                          'CM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                        value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value)
                        {
                          setState(()
                          {
                            height = value;
                          });
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'WEIGHT',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            width: 5.0 ,
                          ),
                          Text(
                            '${weight}',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton (
                                onPressed: ()
                                {
                                  setState (()
                                  {
                                    weight--;
                                  }
                                  );
                                } ,
                                heroTag: 'Weight-',
                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),


                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              FloatingActionButton (
                                onPressed: ()
                                {
                                  setState (()
                                  {
                                    weight++;
                                  }
                                  );
                                } ,
                                heroTag: 'Weight+',
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),


                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            width: 5.0 ,
                          ),
                          Text(
                            '${age}',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton(
                                onPressed: ()
                                {
                                  setState (()
                                  {
                                    age--;
                                  }
                                  );
                                },
                                heroTag: 'Age-',

                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              FloatingActionButton(
                                onPressed: ()
                                {
                                  setState (()
                                  {
                                    age++;
                                  }
                                  );
                                },
                                heroTag: 'Age+',
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.black,
            child: MaterialButton (
              height: 50.0,
            onPressed: ()
            {
              double result = weight / pow(height / 100, 2);
              print(result.round());
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BMIResultScreen(
                    result: result.round() ,
                    isMale: isMale ,
                    age: age ,
                  ) )
              );
            } ,
            child: Text(
              'CALCULATE',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            ),
          )
        ],
      ),
    );
  }
}
