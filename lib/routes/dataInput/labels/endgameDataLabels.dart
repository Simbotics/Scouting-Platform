// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Row3Labels extends StatefulWidget {
  const Row3Labels({
    Key? key,
  }) : super(key: key);

  @override
  _Row3labelsState createState() => _Row3labelsState();
}

class _Row3labelsState extends State<Row3Labels> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
          //hanging?
          Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 170.0,
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: 
                const Text(
                  "Endgame",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                
                ),
              ) 
          ),
          //climb time
          Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 170.0,
            margin: const EdgeInsets.only(left: 55.0),
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: 
                const Text(
                  "Climb Time",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                
                ),
              ) 
          ),
          //trap?
          Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 170.0,
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: 
                const Text(
                  "Trap",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                
                ),
              ) 
          ),
        
        const Divider(),
        ],
    );
  }
}