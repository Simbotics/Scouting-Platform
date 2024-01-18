// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:scouting_platform/builders/fields/counterNumberField.dart';
import 'package:scouting_platform/builders/fields/dropdownMenu.dart';
import 'package:scouting_platform/builders/fields/stopwatchButton.dart';
import 'package:scouting_platform/utils/data/data.dart';

class Row3Fields extends StatefulWidget {
  const Row3Fields({
    Key? key,
  }) : super(key: key);

  @override
  _Row3FieldsState createState() => _Row3FieldsState();
}

class _Row3FieldsState extends State<Row3Fields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //climb dropdown
       ScoutingDropdownMenu(
          dropdownMenuSelectedItem: Data.climb.text, 
          onChanged: (value) {
              setState(() {
                Data.climb.text = value;
              });
            },
          dropdownItems: Data.yesNoOptions, 
          margin: const EdgeInsets.only(left: 20)),
        //climb time
        StopwatchButton(
          text: Data.stopwatchText, 
          stopwatchMethod: (){
         
            if(Data.stopwatchState == 1){
                
                Data.stopwatchText = (Data.stopwatch.elapsedMilliseconds / 1000).toString() + "s";
                Data.stopwatch.stop();
                Data.stopwatchState = 2;
            }
            else if(Data.stopwatchState == 2){
                Data.stopwatch.reset();
                Data.stopwatchText = "Start Timer";
                Data.stopwatchState = 0;
            }else{
                Data.stopwatch.start();
                Data.stopwatchState = 1;
                Data.stopwatchText = "Stop Timer";   
            }
                
                
             
          }),
        //trap
        CounterNumberField(
          onTapDecrement: () {
             int currentValue = int.parse(Data.trap.text);

             Future.delayed(Duration.zero,(){
       //your code goes here
       setState((){
        currentValue--;
              Data.trap.text = currentValue.toString();
      } );
  });        
          }, 
          onTapIncrement: () { 
               int currentValue = int.parse(Data.trap.text);

             Future.delayed(Duration.zero,(){
       //your code goes here
       setState((){
              currentValue++;
              Data.trap.text = currentValue.toString();
      } );
  });        

 
            }, 
          controller: Data.trap),
        //spotlight
        ScoutingDropdownMenu(
          dropdownMenuSelectedItem: Data.spotlight.text, 
          onChanged: (value) {
              setState(() {
                Data.spotlight.text = value;
              });
            },
          dropdownItems: Data.yesNoOptions, 
          margin: const EdgeInsets.only(left: 20)),
        ],
    );
  }
}