import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class TextComposer extends StatefulWidget {

 final Function({String text, File imgFile}) sendMessage;

  TextComposer(this.sendMessage);


  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

// Para ver se está fazendo um texto ou não
bool _isComposing = false; 

void _reset(){
    _controller.clear();
      setState(() {
     _isComposing= false;
       });
}
  @override
  Widget build(BuildContext context) {
    //responsavel pela parte de baixo do chat 
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_camera),
          //responsavel por abrir a camera e tirar uma foto
          onPressed: () async{
      // ignore: deprecated_member_use
      final File imgFile = 
      // ignore: deprecated_member_use
      await ImagePicker.pickImage(source: ImageSource.camera);
      if (imgFile ==null) return;
        widget.sendMessage(imgFile: imgFile);

          },
        ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: 'Enviar uma mensagem...'),
              onChanged: (text){
               setState(() {
                 _isComposing = text.isNotEmpty;
               });
              },
              onSubmitted: (text){
               widget.sendMessage(text: text);
              _reset();
              },
            ), 
          ),
          IconButton(
            icon: Icon(Icons.send), 
            onPressed: _isComposing ? (){  
               widget.sendMessage(text: _controller.text);
              _reset();
           }: null,
          ),
      ],
      ),
    );
  }
}