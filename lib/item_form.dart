import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemForm extends StatefulWidget {
  ItemForm({Key key,
  @required this.callbackName,
  @required this.callbackPrice,
  @required this.callbackAmount}) : super(key: key);

  final callbackName;
  
  final callbackPrice;
  
  final callbackAmount;

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  
  int _n = 1;

  void add() {
    setState(() {
      _n++;
    });
    widget.callbackAmount(_n);
  }

  void minus() {
    setState(() {
      if (_n > 1) 
        _n--;
    });
    widget.callbackAmount(_n);
  }

  @override
  Widget build(BuildContext context) {
    
    return Form(
        child: SingleChildScrollView(
          //padding: EdgeInsets.only(bottom: 50.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Nome do Produto"),
                onChanged: widget.callbackName,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Preço do Produto", prefix: Text("R\$ ")),
                onChanged: widget.callbackPrice,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: minus,
                      mini: true,
                      child: Icon(Icons.remove, color: Colors.white,),
                      backgroundColor: Colors.teal,
                    ),
                    Text('$_n', style: TextStyle(fontSize: 14.0)),
                    FloatingActionButton(
                      onPressed: add,
                      mini: true,
                      child: Icon(Icons.add, color: Colors.white,),
                      backgroundColor: Colors.teal
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      );
  }
}