import 'package:bots_challenge_2/src/widgets/interfaz_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map> listaMensaje = [];

  final mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: listaMensaje.length,
                itemBuilder: (BuildContext context, int index) {
                  return InterfazChat(
                    data: listaMensaje[index]['data'],
                    mensaje: listaMensaje[index]['mensaje'],
                    imagen: listaMensaje[index]['imagenUrl'],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: Colors.lightBlue,
                  width: 2,
                )),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: mensajeController,
                        decoration: InputDecoration(
                          hintText: 'Escriba su menasje',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.near_me),
                        onPressed: () {
                          setState(() {
                            if (mensajeController.text.isNotEmpty) {
                              listaMensaje.insert(0, {
                                'data': 1,
                                'mensaje': mensajeController.text,
                              });
                              respuestaBot(mensajeController.text);
                              mensajeController.clear();
                            }
                          });
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void respuestaBot(String query) async {
    print(query);
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/json/pruebaBot.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    // print(response.getListMessage());
    print(response.getListMessage()[1]['basicCard']['image']['imageUri']);
    setState(() {
      // listaMensaje.insert(0, {
      //   'data': 0,
      //   'mensaje': response.getMessage(),
      // });
      listaMensaje.insert(0, {
        'data': 0,
        'mensaje': response
            .getListMessage()[0]['simpleResponses']['simpleResponses'][0]
                ['textToSpeech']
            .toString(),
        'imagenUrl': response
            .getListMessage()[1]['basicCard']['image']['imageUri']
            .toString(),
      });
    });
  }
}
