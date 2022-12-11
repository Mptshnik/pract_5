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
  late int currentTheme;

  Future<void> loadPrefs() async {
    sharedPreferences = await _prefs;
  }

  @override
  Widget build(BuildContext context) {
    loadPrefs();

    var data = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic> values = data as Map<String, dynamic>;

    if (data != null) {
      text = data['TEXT'];
      currentTheme = data['THEME'] as int;
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
              /*
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
              ),*/
              SizedBox(
                width: 300,
                height: 35,
                child: ElevatedButton(
                    onPressed: () {
                      sharedPreferences.setString('TEXT', text);
                      sharedPreferences.setInt('THEME', currentTheme);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Данные успешно сохранены'),
                        ),
                      );
                    },
                    child: Text('Сохранить')),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 300,
            height: 35,
            child: ElevatedButton(
                onPressed: () {
                  if (sharedPreferences.getString('TEXT') != null &&
                      sharedPreferences.getInt('THEME') != null) {
                    sharedPreferences.remove('TEXT');
                    sharedPreferences.remove('THEME');

                    Navigator.pushNamed(context, 'first_page');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Нет данных для удаления'),
                      ),
                    );
                  }
                },
                child: Text('Очистить данные')),
          ),
        ],
      )),
    );
  }
}
