import 'package:flutter/material.dart';
import 'package:orse/item_form.dart';
import 'package:orse/item.dart';

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
  List<Item> items = [];
  
  void _addItem(Item newItem) {  
    setState(() {
      items = List.from(items)..add(newItem);
      total += newItem.price*newItem.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(items);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      //drawer: Drawer(),
      body: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: items.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Dismissible(
            key: Key(items[index].name + ", " + items[index].price.toString()),
            background: Container(color: Colors.red),
            //direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                items = List.from(items)..removeAt(index);
              });

              Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text(items[index].name + " removido")));
            },
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context){
                    return ItemForm(
                      item: items[index], 
                      callbackAddItem: (Item item) {
                        setState(() {
                          items[index] = item;
                        });
                      }
                    );
                  }
                );
              },
              title: Text(items[index].name),
              subtitle: Text('R\$ ' + items[index].price.toString()),
              trailing: ClipOval(
                child: Container(
                  color: Colors.teal,
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Text(
                      items[index].amount.toString(), 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.white
                      )
                    )
                  )
                )
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              color: Colors.teal,
              elevation: 6,
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
              ),
            ),
            FloatingActionButton(
              tooltip: 'Adicionar Item',
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context){
                    return ItemForm(callbackAddItem: _addItem);
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