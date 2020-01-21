import 'package:flutter/material.dart';

class CTemp extends StatelessWidget {
  bool enabled;
  Function swap;
  
  CTemp({this.enabled, this.swap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (!enabled){
          enabled = !enabled;
          swap();
        }
      },
      child: Container(
      width: 50,
      height: 40,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      padding: EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 0.0),
      decoration: BoxDecoration(
        color:  enabled ? Colors.black : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0)),
            border: Border.all(width: 1.0),
      ),
      child: Text(
        "˚C",
        style: TextStyle(
          color: enabled ? Colors.white : Colors.black,
          fontSize: 24,
        ),
      ),
    ),
  );
  }
  
}