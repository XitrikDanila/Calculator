import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double buttonHeight = 73.0;
    double buttonWidth = 75.0;

    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: () => onPressed(text),
      child: Ink(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  // Определение цвета текста в зависимости от значения кнопки
  Color getColor(String text) {
    if (text == "÷" ||
        text == "×" ||
        text == "+" ||
        text == "-" ||
        text == "%") {
      return const Color(0xFF66FF7F);
    }
    if (text == "C" || text == "=") {
      return const Color(0xFF343434);
    }
    return Colors.white;
  }

  // Определение фона кнопки в зависимости от значения
  Color getBgColor(String text) {
    if (text == "C") {
      return const Color(0xFFFF5959);
    }
    if (text == "=") {
      return const Color(0xFF66FF7F);
    }
    return const Color(0xFF343434);
  }
}
