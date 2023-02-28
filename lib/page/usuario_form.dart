import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/api_client.dart';

class UsuarioForm extends StatefulWidget {
  UsuarioForm({
    Key? key,
    this.id,
    this.endereco_id,
    this.pontoId,
    this.perfil,
    this.us,
  }) : super(key: key);

  var id;
  var endereco_id;
  var pontoId;
  var perfil;
  var us;

  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  final GlobalKey<FormState> _formulario = GlobalKey<FormState>();
  final GlobalKey<FormState> _formulario2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formulario3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formulario4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formulario5 = GlobalKey<FormState>();

  late String data;
  late final String _sexo;

  Future _postUsuario() async {
    var dadosUsuario = json.encode({
      'name': _nomeController.text,
      'email': _emailController.text,
      'password': _senhaController.text,
      'phone': _telefoneController.text,
      'type': "adm",
      'forget': "N"
    });
    await Client.create(dadosUsuario, "usuario");
  }

  loadForEdit() async {}

  _updateUsuario() async {}

  @override
  void initState() {
    loadForEdit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar Novo Usuário",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(70, 168, 177, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 620.0,
          color: const Color.fromRGBO(255, 255, 255, 1),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 100.0,
                child: Form(
                  key: _formulario,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          FormT(
                            200,
                            50,
                            _nomeController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Nome',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          FormT(
                            200.0,
                            50.0,
                            _telefoneController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Telefone',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                height: 100.0,
                child: Form(
                  key: _formulario3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          FormT(
                            200.0,
                            50.0,
                            _emailController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Email',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          FormT(
                              200.0,
                              50.0,
                              _senhaController,
                              TextInputType.text,
                              "Antônio Carlos",
                              "Senha",
                              Colors.blue,
                              25.0)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 10.0,
                    left: 400.0,
                    right: 400.0,
                  ),
                  child: SizedBox(
                    height: 50.0,
                    width: 10.0,
                    child: OutlinedButton(
                      child: Text(
                        widget.id != null ? "ATUALIZAR" : "CADASTRAR",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formulario.currentState!.validate()) {
                          var action =
                              widget.id != null ? _updateUsuario : _postUsuario;
                          await action();
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  alerta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ERRO"),
          content: const Text("ERRO AO SALVAR DADOS, TENTE NOVAMENTE"),
          backgroundColor: const Color.fromRGBO(70, 168, 177, 1),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget FormT(double width, double height, controle, typeInput, String hint,
      String label, font, color) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          // key: _formulario,
          controller: controle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //icon: Icon(Icons.person),
            hintText: hint,
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 25.0,
            ),
          ),
          // ignore: missing_return
          validator: (value) {
            if (value!.isEmpty) {
              return "CAMPO OBRIGATÓRIO";
            }
            return null;
          },
        ),
      ),
    );
  }
}
