import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> checkIfNewCustomer(String firstName, String lastName) async {
  final response = await http.post(
    Uri.parse("https://mhmdghosn.000webhostapp.com/Project2/checkNew.php"),
    body: {
      "first_name": firstName,
      "last_name": lastName,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['isNew'];
  } else {
    throw Exception("Failed to check if the customer is new");
  }
}
