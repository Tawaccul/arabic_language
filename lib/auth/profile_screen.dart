import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/person_icon.png'), // Замените на свою иконку
          ),
          SizedBox(height: 8.0),
          Text(
            'Имя аккаунта',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 16.0),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              buildStatTableRow('Уровень', '5', 'Дней в приложении', '30'),
              buildStatTableRow('Количество слов', '500', 'Цель', '1000'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Добавьте сюда код для изменения профиля
                  print('Изменить');
                },
                child: Text('Изменить'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Добавьте сюда код для выхода
                  print('Выйти');
                },
                child: Text('Выйти'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow buildStatTableRow(String label1, String value1, String label2, String value2) {
    return TableRow(
      children: [
        buildStatTableCell(label1, value1),
        buildStatTableCell(label2, value2),
      ],
    );
  }

  Widget buildStatTableCell(String label, String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}