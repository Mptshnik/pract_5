import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _textController = TextEditingController();

  Future<void> loadPrefs() async {
    final SharedPreferences prefs = await _prefs;

    log(prefs.getString('TEXT').toString());

    if (prefs.getString('TEXT') != null) {
      Navigator.pushNamed(context, 'second_page',
          arguments: prefs.getString('TEXT'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments;

    if (data != null) {
      _textController.text = data.toString();
    }

    loadPrefs();

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: SizedBox(
                width: 300,
                height: 35,
                child: TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                      labelText: 'Введите текст', border: OutlineInputBorder()),
                )),
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  child: Text('Отправить'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'second_page',
                        arguments: _textController.text);
                  },
                ),
              ))
        ],
      )),
    );
  }
}
