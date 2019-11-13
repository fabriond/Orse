class Item {
  
  String name;
  int amount;
  double price;

  Item({this.name, this.price, this.amount = 1});
  Item.copy(Item oldItem){
    name = oldItem.name;
    price = oldItem.price;
    amount = oldItem.amount;
  }

}