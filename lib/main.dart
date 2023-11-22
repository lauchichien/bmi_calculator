import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _heightSliderValue = 0.00;
  double _weightSliderValue = 0.00;
  var _bmi = 0;
  var _bmiText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("BMI Calculator",style: TextStyle(fontSize: 32,color: Colors.lightBlue),),

              Image.network("https://www.pnbmetlife.com/content/dam/pnb-metlife/images/icons/bmi-calculator/meter.png"),

              Text("We care about your health",style: TextStyle(fontSize: 25),),

              Text("Hight (${_heightSliderValue.round()} cm)",style: TextStyle(fontSize: 25),),
              Slider(
                value: _heightSliderValue,
                max: 250,
                onChanged: (double value) {
                  setState(() {
                    _heightSliderValue = value;
                  });
                },
              ),

              Text("Weight (${_weightSliderValue.round()} kg)",style: TextStyle(fontSize: 25),),
              Slider(
                value: _weightSliderValue,
                max: 200,
                onChanged: (double value) {
                  setState(() {
                    _weightSliderValue = value;
                  });
                },
              ),

              _bmi != 0? Text ("Your BMI is $_bmi", style: _bmi < 18 || _bmi > 25 ?
                TextStyle(color: Colors.red, fontSize: 20):
                TextStyle(color: Colors.green, fontSize: 20)): SizedBox(),
              Text ("$_bmiText",style: TextStyle(fontSize: 20),),

              TextButton.icon(onPressed: (){
                //BMI = (weight in kg) / (height in m) ^2
                //import 'dart:math';
                var bmiTemp = _weightSliderValue / pow((_heightSliderValue/100),2);
                print(bmiTemp);

                var messageTemp = "";
                if(bmiTemp <18){
                  messageTemp= "You are underweight";
                }else if (bmiTemp < 25){
                  messageTemp= "You are normal";
                }else if (bmiTemp < 30){
                  messageTemp= "You are overweight";
                }else {
                  messageTemp= "You are obese";
                }
                //In Flutter and React, this means assigning the value bmiTemp.round in _bmi
                //_bmi = bmiTemp.round();

                //So In this Flutter and React Natice, this means assigning the value AND REFRESH THE UI
                setState(() {
                  _bmi = bmiTemp.round();
                  _bmiText = messageTemp;
                });
              },
                  icon: Icon(Icons.favorite),
                  label: Text("Calculate BMI",style: TextStyle(fontSize: 20)),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.yellow),
                    backgroundColor: MaterialStateProperty.all(Colors.black), // Set the background color to red
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}