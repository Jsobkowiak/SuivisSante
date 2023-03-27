import 'package:flutter_suivis_sante/api/config.dart';
import 'package:flutter_suivis_sante/api/local.dart';
import 'package:flutter_suivis_sante/object/mesure.dart';
import 'package:flutter_suivis_sante/object/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  static String? codeResponse;
  Map<dynamic, dynamic> mesures =  Map();


  static Future<void> Connected(String email, String password) async {
    var getToken = http.post(Uri.parse(Config.url + "authentication_token"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
      <String, String>{'email': email, 'password': password}));
    var response = await getToken;

    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body);
      Local.Token = token['token'].toString();
      Local.nom = token["data"]["nom"].toString();
      Local.prenom = token["data"]["prenom"].toString();
      Local.idUser = token["data"]["id"].toString();
      Local.email = email;
      print(token);
      print(Local.idUser);
    } else {
      print(response.statusCode);
      print(Local.Token);
    }
  }

  static Future<void> CreateUser(User user) async {
    var getToken = http.post(Uri.parse(Config.url + "users"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, dynamic>{
          'email': user.getEmail(),
          'password': user.getMdp(),
          'nom': user.getNom(),
          'prenom': user.getPrenom(),
          'roles': ["ROLE_USER"]
        }));
    var response = await getToken;

    if (response.statusCode == 201) {
      codeResponse = "201";
      print("created");
    }
  }

  static Future<void> CreateMesure(Mesure mesure) async {

    var envoiemesure = http.post(Uri.parse(Config.url + "mesures"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, dynamic>{
          "taille": mesure.getTaille(),
          "poids": mesure.getPoids(),
          "IMC": mesure.getImc(),
          "user": "/api/users/${Local.idUser}",
          "datemesure": mesure.getDateMesure().toString()
        }));

    var response = await envoiemesure;

    print("/santeAPI/public/api/users/${Local.idUser}");
    print(response.statusCode);
    if (response.statusCode == 201) {
      codeResponse = "201";
      print("created");
    }
  }
  
  static Future<void> GetMusureByUserID() async{
    var getMesures = await http.get(Uri.parse(Config.url + "users/"+ Local.idUser),
    headers:<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if(getMesures.statusCode == 200){
      print("bien recup");
      var user = convert.jsonDecode(getMesures.body);
      for(var element in user["mesures"]){
          print(element);
          Mesure mesure =  Mesure(element["taille"], element["poids"],element["IMC"], DateTime.parse(element["datemesure"]));
          Local.listemesures.add(mesure);
          print(Local.listemesures);

      }
    }
  }
}
