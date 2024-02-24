import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade200),
      child: Row(children: [
        CircleAvatar(
          child: Icon(Icons.group),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Text(
            "ECE EN1R2012",
            style:
                TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
        ),
      ]),
    );
  }
}
