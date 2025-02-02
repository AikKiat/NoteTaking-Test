import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget 
{
  final Function(String) callback; //creating a callback function instance
  const TextInputWidget(this.callback, {super.key});


  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> 
{
  final controller = TextEditingController();

  @override
  void dispose()
  {
    super.dispose();
    controller.dispose;
  }

  void click()
  {
    widget.callback(controller.text);
    //FocusScope.of(context).unfocus();
    //controller.clear();
  }

  @override
  Widget build(BuildContext context) 
  {
    return TextField
    (controller: controller,
      decoration: InputDecoration
      (prefixIcon: Icon(Icons.message), 
        labelText: "Type something!", 
        suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: click,
                              splashColor: Colors.green,tooltip: "Send message now!",),
      ),
    );
  }
}