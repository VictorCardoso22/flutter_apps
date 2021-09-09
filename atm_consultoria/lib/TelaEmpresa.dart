import 'package:flutter/material.dart';

class TelaEmpresa extends StatefulWidget {
  const TelaEmpresa({Key? key}) : super(key: key);

  @override
  _TelaEmpresaState createState() => _TelaEmpresaState();
}

class _TelaEmpresaState extends State<TelaEmpresa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Empresa"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("imagens/detalhe_empresa.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Sobre a Empresa",
                      style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tortor nunc, varius et ultricies nec, sollicitudin non sapien. In fermentum aliquam sapien, eget volutpat sapien viverra sed. Etiam ac lacus congue enim posuere scelerisque. Vestibulum condimentum leo a est fringilla, at tempus nibh molestie. Morbi sed sem a tortor placerat sollicitudin id eget nunc. Donec id malesuada urna, vitae posuere magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at augue quis odio ullamcorper ornare.  euismod augue quam. Duis metus enim, tempor vitae dui sed, finibus vehicula nibh. Suspendisse potenti. Donec id dolor eu odio pulvinar rhoncus. Pellentesque ligula urna, posuere a pharetra et, auctor ac neque. Vestibulum eu lorem nisi. Mauris convallis finibus porttitor. Maecenas convallis enim sagittis posuere ultricies. Aliquam erat volutpat. Duis varius gravida felis gravida elementum. Proin id molestie nisl. Suspendisse cursus augue viverra, pellentesque arcu et, eleifend enim. Maecenas ac libero eget lectus faucibus finibus."
                    "Mauris et purus aliquam, efficitur elit vitae, aliquet sapien. Suspendisse nec pharetra diam, ut lobortis quam. Maecenas vel lacinia elit. In aliquam ultricies lectus ut tincidunt. Maecenas ut vehicula lectus. Morbi maximus magna id felis egestas ultricies. Vestibulum vitae commodo lectus. Mauris in fermentum sapien. Duis rhoncus ullamcorper mi, vel sagittis mi semper non."
                    "Vivamus sed placerat quam, nec venenatis nulla. Nunc auctor ipsum id sem dapibus, nec malesuada nisl ullamcorper. Suspendisse interdum mauris sem. Sed mattis faucibus molestie. Proin pharetra ex risus, molestie convallis orci malesuada in. Praesent rutrum nulla eu diam consectetur euismod. Aliquam ut lectus tortor. Nam blandit porta vestibulum. Integer interdum erat lorem, vitae facilisis dui vehicula et. Pellentesque a sapien eu lacus consequat bibendum. Donec vulputate, tellus et vestibulum vestibulum, ligula dui malesuada magna, in tempus dui quam in lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    "Pellentesque dignissim nisi ac risus varius imperdiet. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse pretium eros et egestas faucibus. Donec id mollis enim, ut scelerisque orci. Quisque laoreet finibus sem, nec condimentum nulla convallis dictum. Nulla sagittis convallis venenatis. Phasellus consequat mauris id justo ultricies egestas. Fusce elit dolor, rhoncus vitae sollicitudin id, fermentum sodales odio."
                    "Foram gerados 5 parágrafos, 358 palavras e 2518 bytes de Lorem Ipsum"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
