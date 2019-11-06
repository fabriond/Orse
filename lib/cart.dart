import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  int _n = 0;
  List<Widget> items = [];

  void _addItem(name, amount, price) {
    print("ENTREI NA ADD ITEM\n");
    setState(() {
      items.add(
        ListTile(
          title: name,
          subtitle: price,
          trailing: Text(amount),
        )
      );
    });
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) 
        _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(),
      body: Center(
        child: ListView(
          children: items
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Novo item da lista"),
                content: Form(
                  child: SingleChildScrollView(
                    //padding: EdgeInsets.only(bottom: 50.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Nome do Produto"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Preço do Produto", prefix: Text("R\$ ")),
                          keyboardType: TextInputType.number,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FloatingActionButton(
                                onPressed: add,
                                child: Icon(Icons.add, color: Colors.black,),
                                backgroundColor: Colors.white,
                              ),
                              Text('$_n', style: TextStyle(fontSize: 14.0)),
                              FloatingActionButton(
                                onPressed: minus,
                                child: Icon(Icons.remove, color: Colors.black,),
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
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