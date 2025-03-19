import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

// Requête POST
Future<String> postRequest(Map<String, dynamic> data,String apiUrl) async {

  Dio dio = Dio();
  try {
    Response response = await dio.post(
      apiUrl,
      data: data,
    );

    if (response.statusCode == 200) {
      print("Requête post réussie : ${response.data}");
      return "success";
    } else {
      print("Réponse inattendue : ${response.data}");
    }
    return response.data;
  } catch (e) {
    if (e is DioException) {
      print("Erreur API : ${e.response?.statusCode} - ${e.response?.data}");
      //Si le mail existe déjà on l'indique
      if (e.response?.statusCode == 400) {
        return "mail already exists";
      }
      return "problem";
    } else {
      print("Erreur de connexion à l'API : $e");
      
      return "problem";
    }
    
  }
}

Future<Stream<String>> streamRequest(Map<String, dynamic> data, String apiUrl) async {
  Dio dio = Dio();
  try {
    // Set the response type to stream.
    Response<ResponseBody> response = await dio.post<ResponseBody>(
      apiUrl,
      data: data,
      options: Options(responseType: ResponseType.stream),
    );

    if (response.statusCode == 200) {
      Stream<String> stream = utf8.decoder.bind(response.data!.stream).transform(LineSplitter());
      return stream;
    } else {
      throw Exception("Réponse inattendue : ${response.statusCode}");
    }
  } catch (e) {
    print("Erreur lors de la requête en streaming : $e");
    rethrow;
  }
}

Future<void> get(url) async {
  final dio = Dio(); // Create Dio instance

  try {
    Response response = await dio.get(url); // Replace with your API URL
    if (response.statusCode == 200) {
      return(response.data); // Handle the response data
    }
  } catch (e) {
    print('Error: $e'); // Handle errors
  }
}

Future<List<Map<String, dynamic>>> getRecipe(String url) async {
    final dio = Dio(); // Create Dio instance
  
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        return [Map<String, dynamic>.from(response.data)];
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchSearchResults(String query) async {
  try {
    final response = await Dio().post(
      'https://', 
      data: {'query': query},
    );
    
    if (response.statusCode == 200) {
      return response.data;  // Assuming the response contains a list of results?
    } else {
      throw Exception('Failed to load search results');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

