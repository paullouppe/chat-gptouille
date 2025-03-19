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



// Requête GET