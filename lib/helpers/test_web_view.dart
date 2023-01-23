// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
 
// class WebView extends StatelessWidget {
//   Future fetchPost() async {
//     final response =
//     await http.get('http://alkadhum-col.edu.iq/wp-json/wp/v2/posts/');

//     if (response.statusCode == 200) {
//       // If the call to the server was successful, parse the JSON
//       List<dynamic> values=new List<dynamic>();
//       values = json.decode(response.body);
//       if(values.length>0){
//         for(int i=0;i<values.length;i++){
//           if(values[i]!=null){
//             Map<String,dynamic> map=values[i];
//             _postList .add(Post.fromJson(map));
//             debugPrint('Id-------${map['id']}');
//           }
//         }
//       }
//       return _postList;

//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(

//       url:
//           "https://www.google.com/search?q=roofus+treepie+fact+wikipedia&ei=xnvmYIOEDNuX4-EP1uWjeA&oq=roofus+treepie+fact+wikipedia&gs_lcp=Cgdnd3Mtd2l6EAM6BwgAEEcQsAM6BAghEBVKBQhAEgExSgQIQRgAUP4yWL1XYIBcaAFwAXgAgAHHAYgB7Q-SAQQwLjExmAEAoAEBqgEHZ3dzLXdpesgBBMABAQ&sclient=gws-wiz&ved=0ahUKEwiD_5OxztLxAhXbyzgGHdbyCA8Q4dUDCA4&uact=5",
//     );
//   }
// }
