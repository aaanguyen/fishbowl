import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  int i;

  SelectableCard({this.i});

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = isSelected ? false : true;
          print(isSelected);
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration:
              BoxDecoration(color: isSelected ? Colors.white : Colors.yellow),
          child: Text(
            'text ${widget.i}',
            style: TextStyle(fontSize: 30.0, color: Colors.black),
          )),
    );
    ;
  }
}
