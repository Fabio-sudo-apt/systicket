import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:systikcet/page/painel_adm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:systikcet/page/widget/text_form_field.dart';
import '../auth/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: const Color.fromRGBO(255, 176, 102, 1),
              child: SizedBox(
                width: 600.0,
                height: 600.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/img/kombi-login-reco.jpg",
                        height: 100.0,
                        width: 500.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: 400.0,
                  height: 600.0,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 176, 102, 1),
                              fontSize: 64.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormFieldLogin(
                          labelText: "Usuário",
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                        ),
                        TextFormFieldLogin(
                          labelText: "Senha",
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const RoundedRectangleBorder(),
                              backgroundColor:
                                  const Color.fromRGBO(255, 176, 102, 1),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                if ((_emailController.text == "admin" &&
                                        _passwordController.text == "123qwe") ||
                                    (_emailController.text == "carlos" &&
                                        _passwordController.text == "123456") ||
                                    (_emailController.text == "fabio" &&
                                        _passwordController.text == "123456") ||
                                    (_emailController.text == "vini.jr" &&
                                        _passwordController.text == "123456")) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PainelADM(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Atenção! Login ou Senha incorrentos.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFFF0000),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : const Text(
                                    "ENTRAR",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    Auth auth = Auth();
    final resp = await auth.login(
      _emailController.text,
      _passwordController.text,
    );
    var jsonResponse = json.decode(resp.body);
    if (resp.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(jsonResponse['token']));
      localStorage.setString('user', json.encode(jsonResponse));
      var user = (localStorage.getString('user'));
      return "OK";
    } else {
      return "não ok";
    }
  }
}
