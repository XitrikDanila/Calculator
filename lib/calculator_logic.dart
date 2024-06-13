void handleButtons(String text, Function setState, String userInput,
    String result, String storedValue, Function updateState) {
  // Обработка кнопки "C" (сброс)
  if (text == "C") {
    setState(() {
      updateState("", "0", "0");
    });
  } else if (text == "=") {
    // Обработка кнопки "="
    setState(() {
      String calcResult = calculate(userInput);
      String updatedResult = calcResult;
      if (calcResult.endsWith(".0")) {
        calcResult = calcResult.replaceAll(".0", "");
      }
      if (updatedResult.endsWith(".0")) {
        updatedResult = updatedResult.replaceAll(".0", "");
      }
      updateState(calcResult, updatedResult, updatedResult);
    });
  } else if (text == "+/-") {
    // Обработка кнопки "+/-" (смена знака)
    setState(() {
      if (userInput.isNotEmpty) {
        if (userInput.startsWith('-')) {
          userInput = userInput.substring(1);
        } else {
          userInput = '-' + userInput;
        }
      }
      updateState(userInput, result, storedValue);
    });
  } else if (text == "%") {
    // Обработка кнопки "%"
    setState(() {
      if (userInput.isNotEmpty &&
          !isOperator(userInput[userInput.length - 1])) {
        int index = userInput.lastIndexOf(RegExp(r'\D'));
        if (index != -1) {
          String lastNumber = userInput.substring(index + 1);
          double value = double.parse(lastNumber) / 100;
          userInput = userInput.substring(0, index + 1) + value.toString();
        } else {
          double value = double.parse(userInput) / 100;
          userInput = value.toString();
        }
      } else {
        updateState("Error", "Error", storedValue);
        return;
      }
      updateState(userInput, result, storedValue);
    });
  } else {
    // Обработка всех остальных кнопок (цифры и операторы)
    setState(() {
      if (isOperator(text)) {
        if (userInput.isEmpty || isOperator(userInput[userInput.length - 1])) {
          return;
        } else {
          String calcResult = calculate(userInput);
          String updatedResult = calcResult;
          if (calcResult.endsWith(".0")) {
            calcResult = calcResult.replaceAll(".0", "");
          }
          if (updatedResult.endsWith(".0")) {
            updatedResult = updatedResult.replaceAll(".0", "");
          }
          updateState(calcResult + text, updatedResult, updatedResult);
        }
      } else {
        updateState(userInput + text, result, storedValue);
      }
    });
  }
}

String calculate(String userInput) {
  try {
    String cleanedExpression = userInput.replaceAll(' ', '');
    double result = evaluateExpression(cleanedExpression);

    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toString();
    }
  } catch (e) {
    return "Error";
  }
}

double evaluateExpression(String expression) {
  List<String> tokens = tokenize(expression);
  return evaluate(tokens);
}

List<String> tokenize(String expression) {
  List<String> tokens = [];
  String current = '';
  bool lastCharWasOperator = true;

  for (int i = 0; i < expression.length; i++) {
    String char = expression[i];

    if (isDigitOrDot(char)) {
      current += char;
      lastCharWasOperator = false;
    } else if (isOperator(char)) {
      if (current.isNotEmpty) {
        tokens.add(current);
        current = '';
      }
      if (char == '-' && lastCharWasOperator) {
        current = '-';
      } else {
        tokens.add(char);
        lastCharWasOperator = true;
      }
    } else if (char == ' ') {
      continue;
    }
  }

  if (current.isNotEmpty) {
    tokens.add(current);
  }

  return tokens;
}

double evaluate(List<String> tokens) {
  if (tokens.isEmpty) return 0.0;

  List<double> numbers = [];
  List<String> operations = [];

  for (String token in tokens) {
    if (isDigitOrDot(token)) {
      numbers.add(double.parse(token));
    } else if (isOperator(token)) {
      operations.add(token);
    }
  }

  while (operations.isNotEmpty) {
    String operation = operations.removeAt(0);
    double num1 = numbers.removeAt(0);
    double num2 = numbers.removeAt(0);

    double result;
    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          throw Exception('Error');
        }
        break;
      default:
        throw Exception('Error');
    }

    numbers.insert(0, result);
  }

  return numbers.first;
}

bool isDigitOrDot(String char) {
  return RegExp(r'[0-9.]').hasMatch(char);
}

bool isOperator(String char) {
  return char == '+' || char == '-' || char == '×' || char == '÷';
}
