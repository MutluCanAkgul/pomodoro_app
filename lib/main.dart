import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PomodoroPage(),
    );
  }
}
class PomodoroPage extends StatefulWidget {
  const PomodoroPage ({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPage();
}

class _PomodoroPage extends State<PomodoroPage> {
   Timer? _timer;
    int _seconds = 25 * 60;
    String sure = "";
    bool sureBittiMi = false;
    bool sureDurdur = false;
  void zamanlayiciBaslat(){
    if(_timer != null){
      _timer?.cancel();
      _timer = null;
      sureDurdur = false;
    }
    else{
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
     if(_seconds > 0){
      
      setState(() {
        _seconds --;
      sure = "${(_seconds / 60).floor().toString().padLeft(2,'0')} : ${(_seconds % 60).floor().toString().padLeft(2,'0')} ";
      });
      
      
     }
     else
     {
      if(sureBittiMi){
        _seconds = 25 * 60;
      }
      else
      {
        _seconds = 5 * 60;
      }
     
      sureBittiMi = !sureBittiMi;
      Vibration.vibrate();
     }
    }
    );
    sureDurdur = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(
          gradient: LinearGradient(colors: 
          [
            Colors.red,
          Colors.redAccent
          ],
          begin: Alignment.topLeft,end: Alignment.bottomRight
          )
        
        
      ),
        child: GestureDetector(
          onTap:(){
            zamanlayiciBaslat();
          },
        child: Stack(
          children:[ Positioned(child: GestureDetector(onTap: (){
            zamanlayiciBaslat();
            sureDurdur = !sureDurdur;
          },child: Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/domates.png'),fit:BoxFit.contain)),))),
         
          Center(child: Text(sure,style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 100),))
  ]),
        ),),
      );
    
  }
}