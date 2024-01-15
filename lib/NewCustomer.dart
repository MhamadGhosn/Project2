import 'package:flutter/material.dart';

class NewCustomer {
  String generateUniqueId() {
    DateTime now = DateTime.now();
    String uniqueId = '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}${now.microsecond}';
    return uniqueId;
  }

// Other methods and properties of the NewCustomer class can be added here
}

class NewCustomerPage extends StatefulWidget {
  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  String newCustomerId = "";

  @override
  void initState() {
    super.initState();

    // Generate a new unique ID when the page is initialized
    NewCustomer();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Customer Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Generated ID for the new customer:'),
            Text(
              newCustomerId,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Regenerate the ID when the button is pressed
                NewCustomer();
              },
              child: Text('Generate New ID'),
            ),
          ],
        ),
      ),
    );
  }
}
