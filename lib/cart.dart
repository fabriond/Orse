import 'package:flutter/material.dart';
import 'package:orse/item_form.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  
  double total = 0.0;
  List<Widget> items = [];

  String name;
  double price;
  int amount;


  void _addItem() {
    print("ENTREI NA ADD ITEM\n");
    print(price);
    print("PASSEI NA ADD ITEM\n");
    
    setState(() {
      total += price*amount;
      items.add(
        ListTile(
          title: Text(name),
          subtitle: Text(price.toString()),
          trailing: Text(amount.toString())
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(items);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(),
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            ListView(
              children: items
            ),
            Text('Total: ' + total.toString())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Adicionar Item"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Adicionar'),
                    onPressed: (){
                      _addItem();
                      Navigator.of(context).pop();
                    },
                  ), 
                ],
                content: ItemForm(
                  callbackName: (value) => this.name = value,
                  callbackPrice: (value) => this.price = double.parse(value),
                  callbackAmount: (value) => this.amount = value,
                )
              );
            }
          );
        },
        tooltip: 'Adicionar Item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}