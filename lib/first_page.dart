import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemesEnum { dark, light }

class FirstPage extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;

  FirstPage(this.notifier);

  @override
  State<StatefulWidget> createState() => _FirstPageState(notifier);
}

class _FirstPageState extends State<FirstPage> {
  final ValueNotifier<ThemeMode> notifier;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemesEnum currentTheme = ThemesEnum.light;
  TextEditingController _textController = TextEditingController();

  _FirstPageState(this.notifier);

  Future<void> loadPrefs() async {
    final SharedPreferences prefs = await _prefs;

    String? text = prefs.getString('TEXT');
    int? theme = prefs.getInt('THEME');

    if (text != null && theme != null) {
      Map<String, dynamic> values = {'TEXT': text, 'THEME': theme};

      if (theme == ThemesEnum.light.index) {
        notifier.value = ThemeMode.light;
      } else {
        notifier.value = ThemeMode.dark;
      }

      Navigator.pushNamed(context, 'second_page', arguments: values);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments;

    if (data != null) {
      Map<String, dynamic> values = data as Map<String, dynamic>;
      _textController.text = values['TEXT'];
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
                    Map<String, dynamic> values = {
                      'TEXT': _textController.text,
                      'THEME': currentTheme.index
                    };

                    Navigator.pushNamed(context, 'second_page',
                        arguments: values);
                  },
                ),
              ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          notifier.value = notifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
          currentTheme = notifier.value == ThemeMode.light
              ? ThemesEnum.light
              : ThemesEnum.dark,
        },
        child: Icon(notifier.value == ThemeMode.light
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
      ),
    );
  }
}
