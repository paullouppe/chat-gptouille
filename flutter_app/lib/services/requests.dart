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