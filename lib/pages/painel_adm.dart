import 'package:flutter/material.dart';
import 'package:systikcet/pages/create_route.dart';

class PainelADM extends StatelessWidget {
  const PainelADM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeBox = 100;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Adicionar nova rota",
                    icon: Icons.directions_bus_filled_sharp,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateRouter(),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Ver rotas",
                    icon: Icons.route,
                    onTap: () {},
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Relatorios",
                    icon: Icons.report,
                    onTap: () {},
                  ),
                  Container(
                    width: sizeBox,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Configuração de usuarios",
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Sair",
                    icon: Icons.exit_to_app,
                    onTap: () {},
                  ),
                  Container(
                    width: sizeBox,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector containerConfig({
    required String title,
    required IconData icon,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 176, 102, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 80,
            ),
          ),
          const Divider(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
