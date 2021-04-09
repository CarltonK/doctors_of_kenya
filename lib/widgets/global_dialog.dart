import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalDialog extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const GlobalDialog({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _GlobalDialogState createState() => _GlobalDialogState();
}

class _GlobalDialogState extends State<GlobalDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
 Widget contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding:const EdgeInsets.only(left: 20,top: 65, right: 20,bottom: 20
          ),
          margin: const EdgeInsets.only(top:45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
             const SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
             const SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
            right:20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset("assets/doc.jpg")
              ),
            ),
        ),
      ],
    );
  }
}