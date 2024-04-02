import 'dart:convert';
import 'package:flutter_app/model/favoris.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static String? baseUrl = dotenv.env['API_URL']; // Replace with your API base URL

  Future<List<Favoris>> fetchFavoris() async {
    final response = await http.get(Uri.parse('${baseUrl}/common'));
    if (response.statusCode == 200){
      var jsonString = json.decode(response.body);
      return jsonString.map<Favoris>((fav) => Favoris.fromJson(fav as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load Favoris');
    }
  }

  Future<http.Response> deleteFavoris(Favoris fav) async {
    final http.Response response = await http.delete
    (
      Uri.parse('${baseUrl}/common'), 
      body: json.encode(fav),
      headers: {"Content-Type": "application/json"});
    return response;
  }

  Future<http.Response> addFavoris(Favoris fav) async {
    final http.Response response = await http.post
    (
      Uri.parse('${baseUrl}/common'), 
      body: json.encode(fav),
      headers: {"Content-Type": "application/json"});
    return response;
  }
}