import 'package:flutter/material.dart';
import 'button_grid.dart';
import 'calculator_logic.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Поля для хранения текущего ввода пользователя, результата и сохраненного значения
  String userInput = "";
  String result = "0";
  String storedValue = "0";

  // Список кнопок, которые будут отображаться на калькуляторе
  List<String> buttonList = [
    'C',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  // Метод для обновления состояния калькулятора
  void updateState(
      String newUserInput, String newResult, String newStoredValue) {
    userInput = newUserInput;
    result = newResult;
    storedValue = newStoredValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: Column(
        children: [
          // Экран калькулятора для отображения ввода пользователя и результата
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 30, right: 19, left: 0, bottom: 30),
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      userInput,
                      style: const TextStyle(
                        fontSize: 44,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Отображение результата вычисления
                Container(
                  padding:
                      const EdgeInsets.only(top: 30, right: 19, bottom: 30),
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 44,
                        color: Color(0xFF969696),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Разделитель между экраном и кнопками
          const Padding(
            padding: EdgeInsets.only(right: 19, left: 19, top: 20),
            child: Divider(
              color: Color(0xFF4E4D4D),
              thickness: 1,
            ),
          ),
          // Сетка кнопок калькулятора
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, bottom: 4),
              child: ButtonGrid(
                  buttonList: buttonList,
                  handleButtons: (text) {
                    handleButtons(text, setState, userInput, result,
                        storedValue, updateState);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
