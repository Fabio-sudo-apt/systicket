import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final String _url = 'http://172.16.0.240:3000/login';
  var token;
  // var refreshToken;
  // var perfil;

  //final String  urlFoto ="http://192.168.1.13:8000/storage/";
  getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    return await user['res']['user'];
  }

  getUserId() async {
    var user = await getUser();
    return user['res']['user']['id'];
  }

  getPerfil() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    print(user['res']['user']['perfil']);
    var perfil = user['res']['user']['perfil'];
    return perfil;
  }

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = (localStorage.getString('token'));
    // print(token);
    return token;
  }

//  getRefreshToken() async {
//    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    refreshToken = jsonDecode(localStorage.getString('refresh_token'));
//    //print(refreshToken);
//    return refreshToken;
//  }

  authData(data, {apiUrl}) async {
    var fullUrl = _url + apiUrl;
    Uri urlFull = Uri.parse(fullUrl);
    http.Response response = await http.post(urlFull,
        body: json.encode(data), headers: setHeaders());
    /*return await http.post(
        fullUrl,
        body: json.encode(data),
        headers: _setHeaders()
    );*/
    return response;
  }

//  getData(apiUrl) async {
//    var fullUrl = _url + apiUrl;
//    await getToken();
//    return await http.get(fullUrl, headers: setHeaders());
//  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

//  RefreshToken() async {
//    var ref = await getRefreshToken();
//    print("WRRRRRRRRRRRRRRR");
//    var fullUrl = _url;
//    var dados = {
//      'grant_type': "refresh_token",
//      'client_id': 2,
//      'client_secret': "YeJMF0v4Rrl4x07aJq5oBqoloOPMgCo4SwwM1xcN",
//      'refresh_token': ref
//    };
//    //print("############ $ref");
//    /*FormData formData = new FormData.fromMap({
//      'grant_type': "refresh_token",
//      'client_id': 2,
//      'client_secret': "YeJMF0v4Rrl4x07aJq5oBqoloOPMgCo4SwwM1xcN",
//      'refresh_token': ref
//    });*/
//    http.Response response =
//    await http.post(_url, body: jsonEncode(dados),headers:{'Content-type': 'application/json',
//      'Accept': 'application/json',} );
//    if (response.statusCode == 200) {
//      //print(response.data);
//      var jsonResponse = jsonDecode(response.body);
//      SharedPreferences localStorage = await SharedPreferences.getInstance();
//      localStorage.setString(
//          'token', json.encode(jsonResponse['access_token']));
//      localStorage.setString('user', json.encode(jsonResponse['user']));
//      localStorage.setString(
//          "refresh_token", json.encode(jsonResponse['refresh_token']));
//      //print(response.body);
//    } else {
//      print("##########${response.statusCode} ########");
//      print("##########${response.body} ########");
//
//    }
//    //print("Erro: no refresh ${response.statusCode}");
//    //return response;
//  }
  login(String email, String password) async {
    var dadosLogin = {
      'email': email,
      'password': password,
    };
    print(dadosLogin);
    Uri url = Uri.parse('http://172.16.5.110:3000/login');
    final response =
        await http.post(url, body: jsonEncode(dadosLogin), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      print(response);
      return response;
    }).catchError((error) {
      //return error.toString();
      print(error);
    });
    return response;
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
    localStorage.clear();
    // String rota = "MaterialPageRoute(builder: (context) => Login())";
  }
}
