import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final String imageUrl;
  final double price;

  MenuItem({required this.name, required this.imageUrl, required this.price});
}

class ShowMenu extends StatefulWidget {
  @override
  _ShowMenuState createState() => _ShowMenuState();
}

class _ShowMenuState extends State<ShowMenu> {
  List<MenuItem> menuItems = [
    MenuItem(name: 'Coffee', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX8m-zjuV8cdI8uHXxNuG4S73xj2AWotq0DsTYwGQbaw&s', price: 2.5),
    MenuItem(name: 'Tea', imageUrl: 'https://www.unicornsinthekitchen.com/wp-content/uploads/2019/09/How-To-Brew-Persian-Tea-At-Home-SQ.jpg', price: 5.0),
    MenuItem(name: 'Pepsi Drinks', imageUrl: 'https://c8.alamy.com/comp/2H1JPCN/stuttgart-germany-august-24-2021-pepsi-cola-7-up-lemonade-soft-drinks-in-plastic-bottles-isolated-in-stuttgart-germany-2H1JPCN.jpg', price: 5.0),
  ];

  List<MenuItem> selectedItems = [];

  double calculateTotalPrice() {
    return selectedItems.fold(0, (total, item) => total + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(menuItems[index].imageUrl),
                  title: Text(menuItems[index].name),
                  subtitle: Text('Price: \$${menuItems[index].price.toStringAsFixed(2)}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedItems.add(menuItems[index]);
                      });
                    },
                    child: Text('Add to Order'),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text('Selected Items:'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedItems[index].name),
                subtitle: Text('Price: \$${selectedItems[index].price.toStringAsFixed(2)}'),
              );
            },
          ),
          Divider(),
          Text('Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}


