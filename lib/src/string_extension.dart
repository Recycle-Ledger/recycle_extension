
import 'dart:math';

extension StringExtension on String {
  int get removeCommaToInt {
    try {
      return int.parse(replaceAll(',', ''));
    } catch (error, _) {
      return 0;
    }
  }

  String get removeComma {
    try {
      return replaceAll(',', '');
    } catch (error, _) {
      return this;
    }
  }

  String get businessFormatted {
    if (length < 10) {
      return this;
    }
    String number = replaceAll(RegExp(r'\D'), '');
    String formattedNumber =
        "${number.substring(0, 3)}-${number.substring(3, 5)}-${number.substring(5)}";
    return formattedNumber;
  }

  String get sliceRFID {
    try {
      final slice = substring(length - 8);
      return slice;
    } catch (error, _) {
      return this;
    }
  }

  int convertVersion() {
    List<String> versionStrList = List.from(split('.').reversed);
    int totalVersion = 0;

    // 버전을 비교 계산 하기 위해서 왼쪽 부터 1000^(3-n)씩 곱해서 숫자로 만들어 줌
    // ex) 1.2.1 -> 1 * 1000000 + 2 * 1000 + 1 = 1002001
    // ex) 1.2.13 -> 1 * 1000000 + 2 * 1000 + 13 = 1002013
    // ex) 21.12.1 -> 21 * 1000000 + 12 * 1000 + 1 = 21012001
    // ex) 2.42.32 -> 2 * 1000000 + 42 * 1000 + 32 = 2042032
    // 위의 비교 계산을 위해서 각각의 위치에 있는 버전 넘버는 최대 3자리수 (999) 까지만 설정할 수 있다.
    // ex) 123.999.999 가능 /// 1234.1234.1234 불가능
    for (int i = 0; i < versionStrList.length; i++) {
      int versionNum = int.parse(versionStrList[i]);
      if (i == 0) {
        totalVersion += versionNum;
      } else {
        totalVersion += versionNum * pow(1000, i).toInt();
      }
    }

    return totalVersion;
  }

  String completeEunNeun() {
    final lastName = this[length - 1];

    if (lastName.codeUnitAt(0) < 0xAC00 || lastName.codeUnitAt(0) > 0xD7A3) {
      return this;
    }

    final word = (lastName.codeUnitAt(0) - 0xAC00) % 28 > 0 ? '은' : '는';

    return this + word;
  }

  String completeEulReul() {
    final lastName = this[length - 1];

    if (lastName.codeUnitAt(0) < 0xAC00 || lastName.codeUnitAt(0) > 0xD7A3) {
      return this;
    }

    final word = (lastName.codeUnitAt(0) - 0xAC00) % 28 > 0 ? '을' : '를';

    return this + word;
  }

  String completeIGa() {
    final lastName = this[length - 1];

    if (lastName.codeUnitAt(0) < 0xAC00 || lastName.codeUnitAt(0) > 0xD7A3) {
      return this;
    }

    final word = (lastName.codeUnitAt(0) - 0xAC00) % 28 > 0 ? '이' : '가';

    return this + word;
  }

  String get parseUrl {
    // 주어진 문자열을 뒤에서부터 순차적으로 검사
    for (int i = length - 1; i >= 0; i--) {
      if (this[i] == '/') {
        // '/' 문자를 찾았을 때, '/' 이후의 문자열을 반환
        return substring(i + 1);
      }
    }
    // '/' 문자가 없을 경우, 전체 문자열 반환
    return this;
  }
}

extension NullableStringExtension on String? {
  double toDoubleOrDefault({double? defaultValue}) {
    try {
      return double.parse(this!);
    } catch (_) {
      return defaultValue ?? 0.0;
    }
  }

  int toIntOrDefault({int? defaultValue}) {
    try {
      return int.parse(this!);
    } catch (_) {
      return defaultValue ?? 0;
    }
  }
}
