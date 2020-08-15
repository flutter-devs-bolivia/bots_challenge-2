import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class BurbujasChat extends StatelessWidget {
  final int data;
  final String mensaje;
  final String imagen;

  BurbujasChat({
    @required this.data,
    @required this.mensaje,
    this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Bubble(
          nip: data == 0 ? BubbleNip.leftTop : BubbleNip.rightTop,
          color: data == 0 ? Colors.lightBlue : Colors.green,
          child: Container(
            constraints: BoxConstraints(maxWidth: 200),
            child: imagen != null
                ? Column(
                    children: [
                      Text(
                        mensaje,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Image.network(imagen)
                    ],
                  )
                : Text(
                    mensaje,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
          )),
    );
  }
}
