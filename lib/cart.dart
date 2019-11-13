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
  int amount = 1;
  
  void _addItem() {
    print("ENTREI NA ADD ITEM\n");
    print(price);
    print("PASSEI NA ADD ITEM\n");
  
    setState(() {
      items = List.from(items)..add(
        ListTile(
          title: Text(name),
          subtitle: Text('R\$ ' + price.toString()),
          trailing: ClipOval(
            child: Container(
              color: Colors.teal,
              height: 32,
              width: 32,
              child: Center(child: Text(amount.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
            )
          ),
        ),
      );
      total += price*amount;
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
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: items.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index){
                return Dismissible(
                  key: Key(name + ", " + price.toString()),
                  //direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    print("remove $items[index].length");
                    setState(() {
                      items = List.from(items)..removeAt(index);
                    });

                    Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("$name dismissed")));
                  },
                  child: items[index],
                  background: Container(color: Colors.red)
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal,
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  'R\$ ' + total.toString(),
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                  ),
                )
              ) 
            ),
            FloatingActionButton(
              tooltip: 'Adicionar Item',
              child: Icon(Icons.add),
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
                        callbackPrice: (value) => this.price = double.parse(value.replaceAll(",", ".")),
                        callbackAmount: (value) => this.amount = value,
                      )
                    );
                  }
                );
              },
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        )
      )
    );
  }
}