import 'package:bots_challenge_2/src/widgets/burbujas_chat.dart';
import 'package:flutter/material.dart';

class InterfazChat extends StatelessWidget {
  final int data;
  final String mensaje;
  final String imagen;

  InterfazChat({
    @required this.data,
    @required this.mensaje,
    this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: data == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/robot.png'),
                  ),
                ),
                BurbujasChat(data: data, mensaje: mensaje, imagen: imagen),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BurbujasChat(data: data, mensaje: mensaje),
                Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/usuario.png'),
                  ),
                )
              ],
            ),
    );
  }
}
