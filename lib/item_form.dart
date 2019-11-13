import 'package:flutter/material.dart';
import 'package:orse/item.dart';

class ItemForm extends StatefulWidget {
  ItemForm({Key key, this.callbackAddItem, this.item}) : super(key: key);

  final Item item;
  final Function callbackAddItem;

  @override
  _ItemFormState createState() => _ItemFormState(oldItem: item);
}


class _ItemFormState extends State<ItemForm> {

  _ItemFormState({Item oldItem}){
    if(oldItem == null){
      currentItem = Item();
    } else {
      currentItem = Item.copy(oldItem);
    }
  }

  final _formKey = GlobalKey<FormState>();
  
  Item currentItem;

  void _validateAndAddItem(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.callbackAddItem(currentItem);
      Navigator.of(context).pop();
    } 
  }

  void add() {
    setState(() {
      currentItem.amount++;
    });
  }

  void minus() {
    setState(() {
      if(currentItem.amount > 1) 
        currentItem.amount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.all(Radius.circular(10)) 
      ),
      title: currentItem.name == null ? Text("Adicionar item") : Text("Editar item"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: currentItem.name == null ? null : currentItem.name,
                decoration: InputDecoration(labelText: "Nome do Produto"),
                onSaved: (value) => currentItem.name = value,
                validator: (value) {
                  if(value.isEmpty){
                    return "Nome não pode ser vazio";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: currentItem.price == null ? null : currentItem.price.toStringAsFixed(2),
                decoration: InputDecoration(labelText: "Preço do Produto", prefix: Text("R\$ ")),
                keyboardType: TextInputType.number,
                onSaved: (value) => currentItem.price = double.parse(value.replaceAll(",", ".")),
                validator: (value) {
                  if(value.isEmpty){
                    return "Preço não pode ser vazio";
                  } else if(double.tryParse(value.replaceAll(",", ".")) == null){
                    return "Preço inválido";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
                    Text(currentItem.amount.toString(), style: TextStyle(fontSize: 14.0)),
                    FloatingActionButton(
                      onPressed: add,
                      mini: true,
                      child: Icon(Icons.add, color: Colors.white,),
                      backgroundColor: Colors.teal
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          )
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: (){
            _validateAndAddItem(context);
          },
        ), 
      ],
    );
  }
}
