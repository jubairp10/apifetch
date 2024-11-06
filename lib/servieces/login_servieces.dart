// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:hive/hive.dart';
//
// import '../model/login-model.dart';
//
// class LoginService {
//   Future<Login?> login(String email, String password) async {
//     final url = Uri.parse('https://api.escuelajs.co/api/v1/auth/login');
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({
//         "email": email,
//         "password": password,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final login = Login.fromJson(data);
//       final sessionBox = Hive.box('session');
//       sessionBox.put('accessToken', login.accessToken);
//       sessionBox.put('refreshToken', login.refreshToken);
//       return login;
//     } else {
//       // Handle error
//       return null;
//     }
//   }
// }
