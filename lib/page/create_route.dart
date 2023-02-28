import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateRouter extends StatefulWidget {
  const CreateRouter({Key? key}) : super(key: key);

  @override
  State<CreateRouter> createState() => _CreateRouterState();
}

class _CreateRouterState extends State<CreateRouter> {
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController _subrotaController = TextEditingController();
  final TextEditingController _horarioSaidaController = TextEditingController();

  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horarioEntradaController =
      TextEditingController();
  final TextEditingController _brancoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar rota",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(200.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: paddingInputLeft(),
                  ),
                  Expanded(
                    child: paddingInputRight(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async {
                      final response = await casdastra();
                      print(response);
                      if (response == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Cadstrado com sucesso!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 115, 255, 0),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Cadastra",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      elevation: 2.0,
                      backgroundColor: const Color.fromRGBO(255, 176, 102, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding paddingInputLeft() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                textFormField(title: "Origem", controller: _origemController),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Horário de saida",
              controller: _horarioSaidaController,
            ),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Subrota de rota",
              controller: _subrotaController,
            ),
          ),
        ],
      ),
    );
  }

  Padding paddingInputRight() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Destino",
              controller: _destinoController,
            ),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
                title: "Horário de chegada",
                controller: _horarioEntradaController),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Opcao",
              controller: _brancoController,
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFormField({
    required String title,
    required TextEditingController controller,
  }) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Dados vazio!";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 30.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(171, 169, 166, 1)),
          borderRadius: BorderRadius.circular(2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(171, 169, 166, 1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(171, 169, 166, 1),
            width: 2.0,
          ),
        ),
      ),
    );
  }

  casdastra() async {
    if (formKey.currentState!.validate()) {
      String teste = "https://63ed6b44f1ec53805ddd5e6e.mockapi.io/api/rotas";
      final Uri uri = Uri.parse(teste);
      final String origem = _origemController.value.text;
      final String horarioSaida = _horarioSaidaController.value.text;
      final String subRota = _subrotaController.value.text;

      final String destino = _destinoController.value.text;
      final String horarioEntrada = _horarioEntradaController.value.text;
      final String branco = _brancoController.value.text;
      final data = {
        "origem": origem,
        "horarioS": horarioSaida,
        "horarioEntrada": horarioEntrada,
        "subRota": subRota,
        "destino": destino,
        "branco": branco,
      };
      final response = await http.post(uri, body: data);
      _origemController.text = "";
      _horarioEntradaController.text = "";
      _subrotaController.text = "";
      _destinoController.text = "";
      _subrotaController.text = "";
      _horarioSaidaController.text = "";
      _brancoController.text = "";
      return response.statusCode;
    }
  }
}
