import 'package:flutter/material.dart';

class Box extends StatelessWidget{
  final String title;

  const Box({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(width: 2),
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Text(title),
      )
    );
  }
}

class Topic extends StatelessWidget {
  const Topic({
    super.key,
    required this.onDelete,
    required this.title,
    required this.content,
  });

  final VoidCallback onDelete;
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            title: Text(title, style: TextStyle(color: Colors.black),),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: 16, bottom: 16, left: 10),
                  child: content,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft ,
                child: Padding(
                  padding: EdgeInsets.only(right: 8, bottom: 8),
                  child: ElevatedButton(
                      onPressed: onDelete,
                      child: Icon(
                        Icons.account_balance_sharp,
                        color: Colors.red,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}