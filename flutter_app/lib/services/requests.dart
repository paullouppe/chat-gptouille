import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:developer';

//Stores API requests..

// User info POST request.
Future<String> postRequest(Map<String, dynamic> data, String apiUrl) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      apiUrl,
      data: data,
    );

    if (response.statusCode == 200) {
      //print("Requête post réussie : ${response.data}");
      //Il faut retourner un string tout en gardant une structure json correcte
      return jsonEncode(response.data);
    } else {
      log("Réponse inattendue : ${response.data}");
    }
    return response.data;
  } catch (e) {
    if (e is DioException) {
      log("Erreur API : ${e.response?.statusCode} - ${e.response?.data}");
      // Indicates if email already exists.
      if (e.response?.statusCode == 400) {
        return "mail already exists";
      } else if (e.response?.statusCode == 401) {
        return "Invalid email or password";
      }
      return "problem";
    } else {
      log("Erreur de connexion à l'API : $e");
      return "problem";
    }
  }
}

// Account DELETE request

Future<String> deleteAccountRequest(String accessToken, String apiUrl) async {
  Dio dio = Dio();

  try {
    // Defines headers bases on access token.
    dio.options.headers = {
      'Authorization': 'Bearer $accessToken', // Adds the JWT token.
    };

    // Effectuer la requête DELETE
    Response response = await dio.delete(apiUrl);

    if (response.statusCode == 200) {
      // Succesful deletion.
      return "success";
    } else {
      // Autre réponse HTTP
      return "Erreur lors de la suppression du compte: ${response.statusCode}";
    }
  } catch (e) {
    if (e is DioException) {
      // Manages Dio specific errors.
      log("Erreur API : ${e.response?.statusCode} - ${e.response?.data}");
      return "Erreur de l'API lors de la suppression du compte";
    } else {
      // Manages generic errors.
      log("Erreur de connexion : $e");
      return "Erreur lors de la connexion à l'API";
    }
  }
}

Future<Stream<String>> streamRequest(
    Map<String, dynamic> data, String apiUrl) async {
  Dio dio = Dio();
  try {
    // Set the response type to stream.
    Response<ResponseBody> response = await dio.post<ResponseBody>(
      apiUrl,
      data: data,
      options: Options(responseType: ResponseType.stream),
    );

    if (response.statusCode == 200) {
      Stream<String> stream =
          utf8.decoder.bind(response.data!.stream).transform(LineSplitter());
      return stream;
    } else {
      throw Exception("Réponse inattendue : ${response.statusCode}");
    }
  } catch (e) {
    log("Erreur lors de la requête en streaming : $e");
    rethrow;
  }
}

// GET a recipe from database based on id.
Future<List<Map<String, dynamic>>> getRecipe(String url) async {
  final dio = Dio();

  try {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return [Map<String, dynamic>.from(response.data)];
    } else {
      throw Exception('Failed to load recipes');
    }
  } catch (e) {
    log('Error fetching recipes: $e');
    return [];
  }
}

// GET semantic search results of recipes.
Future<List<dynamic>> fetchSearchResults(String query, int n) async {
  try {
    final response = await Dio().post(
      'http://localhost:8080/recipes/search',
      data: {'name': query, 'n': n},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load search results');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
