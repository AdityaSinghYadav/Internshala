import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internshala/Model/post_model.dart';

class ApiService {
  static const String baseUrl = 'https://internshala.com/flutter_hiring/search';

  // Method to fetch post model data
  static Future<PostModel> fetchPostModel() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      return PostModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load post model');
    }
  }
}
