import 'package:flutter/material.dart';


// Button ในฝัน
RaisedButton buildRaisedButton() {
  return RaisedButton(
    onPressed: () {},
    color: Colors.blueAccent.shade200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: SizedBox(
      width: 80,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
          Text('SCAN', style: TextStyle(color: Colors.white))
        ],
      ),
    ),
  );
}