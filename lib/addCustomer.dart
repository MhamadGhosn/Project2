import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'CheckIfNew.dart';
import 'NewCustomer.dart';


const String _baseURL = 'https://mhmdghosn.000webhostapp.com/Project2/saveCustomer.php';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}class _AddCustomerState extends State<AddCustomer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerID = TextEditingController();
  TextEditingController _controllerFisrtName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _controllerID.dispose();
    _controllerFisrtName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }
  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Customer'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerID,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter ID',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter id';
                  }
                  return null;
                },
              )),
              SizedBox(height: 20,),
              TextButton(onPressed: () async {
                bool isNewCustomer = await checkIfNewCustomer(_controllerFisrtName.text, _controllerLastName.text);

                if (isNewCustomer) {
                  // Navigate to the page where you generate a new ID for the customer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewCustomerPage(),
                    ),
                  );
                } else {
                  // Handle the case when the customer is not new
                  // You can add additional logic here
                }

              }, child: Text('New Customer?')),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerFisrtName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter First Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerLastName,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Last Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
              )),
              SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading ? null : () { // disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    saveCustomer(update, int.parse(_controllerID.text), _controllerFisrtName.text,
                      _controllerLastName.text ,);
                  }
                },
                child: const Text('Go'),
              ),
              const SizedBox(height: 10),
                        const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        )));
  }
}

void saveCustomer(Function(String text) update, int id, String FirstName, String LastName) async {
  try {
    // we need to first retrieve and decrypt the key
    // send a JSON object using http post
    final response = await http.post(
        Uri.parse('$_baseURL/saveCustomer.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, // convert the cid, name and key to a JSON object
        body: convert.jsonEncode(<String, String>{
          'id': '$id', 'FirstName': FirstName, 'LastName':'$LastName', 'key': 'mhmd'
        })).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful, call the update function
      update(response.body);
    }
  }
  catch(e) {
    update(e.toString());
  }
}