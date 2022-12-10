import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final SharedPreferences sharedPreferences;
  late String text = '';

  Future<void> loadPrefs() async {
    sharedPreferences = await _prefs;
  }

  @override
  Widget build(BuildContext context) {
    loadPrefs();

    var data = ModalRoute.of(context)!.settings.arguments;
    if (data != null) {
      text = data.toString();
    }

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ваши данные: ' + text,
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (sharedPreferences.getString('TEXT') == null) {
                      Navigator.pushNamed(context, 'first_page',
                          arguments: text);
                    }
                  },
                  child: Text('Назад')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    sharedPreferences.setString('TEXT', text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Данные успешно сохранены'),
                      ),
                    );
                  },
                  child: Text('Сохранить')),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                sharedPreferences.remove('TEXT');
                Navigator.pushNamed(context, 'first_page');
              },
              child: Text('Очистить данные'))
        ],
      )),
    );
  }
}
