import 'package:flutter/material.dart';

import 'custom_button.dart';

class ButtonGrid extends StatelessWidget {
  // Список кнопок и функция для обработки нажатий на кнопки
  final List<String> buttonList;
  final Function(String) handleButtons;

  ButtonGrid({required this.buttonList, required this.handleButtons});

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    int index = 0;

    // Создаем строки с кнопками (по 4 кнопки в строке)
    for (int i = 0; i < buttonList.length / 4; i++) {
      List<Widget> row = [];
      for (int j = 0; j < 4; j++) {
        if (index < buttonList.length) {
          String text = buttonList[index];
          if (text == '=') {
            // Кнопка "=" занимает две ячейки по горизонтали
            row.add(Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomButton(text: text, onPressed: handleButtons),
              ),
            ));
            index++;
            break;
          } else if (text == '0') {
            row.add(Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomButton(text: text, onPressed: handleButtons),
              ),
            ));
            index++;
            j++;
          } else if (text == '.') {
            row.add(Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomButton(text: text, onPressed: handleButtons),
              ),
            ));
            index++;
          } else {
            // Все остальные кнопки занимают одну ячейку
            row.add(Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(text: text, onPressed: handleButtons),
              ),
            ));
            index++;
          }
        }
      }
      // Добавляем строку в общий список строк
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: row,
      ));
    }
    // Возвращаем колонку из строк с кнопками
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rows,
    );
  }
}
