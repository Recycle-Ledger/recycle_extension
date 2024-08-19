import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isBetween(DateTime startDate, DateTime endDate) {
    // 만약 시간 설정을 하지 않았다면 시간을 그날의 마지막 시간으로 설정해준다.
    if (endDate.hour == 0 && endDate.minute == 0 && endDate.second == 0) {
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

    }
    // 현재 날짜가 시작 날짜와 종료 날짜 사이에 있는지 확인
    return (isAfter(startDate) || isAtSameMomentAs(startDate)) && (isBefore(endDate) || isAtSameMomentAs(endDate));
  }

  /// 월초 구하기
  DateTime getStartOfMonth() {
    return DateTime(year, month, 1);
  }

  /// 월말 구하기
  DateTime getEndOfMonth() {
    // 다음달의 월초를 구한뒤 1밀리세컨드만큼 빼주면 월말 23시 59분 59.999초가 구해짐
    final nextMonth = month < 12 ? month + 1 : 1;
    final nextYear = nextMonth == 1 ? year + 1 : year;
    final endOfMonth = DateTime(nextYear, nextMonth, 1).subtract(const Duration(milliseconds: 1));
    return endOfMonth;
  }

  // 현재 날짜의 한달 전 날짜를 가져온다. 만약 31일까지 있는 달에서 30일이 있는 달로 갈 경우 30일로 자동으로 수정해준다. 2월달도 마찬가지
  DateTime get previousMonth {
    // 현재 날짜의 연도와 월을 가져온다.
    int year = this.year;
    int month = this.month;

    // 이전 달의 연도와 월을 계산
    if (month == 1) {
      // 현재 월이 1월인 경우, 이전 달은 작년 12월
      year -= 1;
      month = 12; // 12월로 설정
    } else {
      // 그 외의 경우, 현재 월에서 1을 빼줌
      month -= 1;
    }
    int endDate = _daysInMonth(year, month);
    if (endDate > day) {
      endDate = day;
    }

    return DateTime(year, month, endDate);
  }

  DateTime get nextMonth {
    // 현재 날짜의 연도와 월을 가져온다
    int year = this.year;
    int month = this.month;

    // 다음 달의 연도와 월을 계산
    if (month == 12) {
      // 현재 월이 12월인 경우, 다음 달은 내년 1월
      year += 1;
      month = 1; // 1월로 설정
    } else {
      // 그 외의 경우, 현재 월에서 1을 더해줌
      month += 1;
    }
    int endDate = _daysInMonth(year, month);
    if (endDate > day) {
      endDate = day;
    }

    return DateTime(year, month, endDate);
  }

  /*String toUtcString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String formattedDate = '$year-${twoDigits(month)}-${twoDigits(day)}';
    String formattedTime = '${twoDigits(hour)}:${twoDigits(minute)}:${twoDigits(second)}';

    return '${formattedDate}T${formattedTime}Z';
  }*/

  String get dateForCurrentLocale {
    final String countryCode = Intl.getCurrentLocale();

    if (countryCode == 'ko') {
      return DateFormat('yyyy년 MM월 dd일').format(this);
    } else {
      return DateFormat('MM, dd, yyyy').format(this);
    }
  }

  String get yyyyMMdd {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String get yyMMdd {
    final DateFormat formatter = DateFormat('yy-MM-dd');
    return formatter.format(this);
  }

  String get yyyyMMddHHmmss {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(this);
  }

  String get yyyyMMddTHHmmssSSS {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    return formatter.format(this);
  }

  // 해당 연도와 월의 일수를 반환하는 함수
  int _daysInMonth(int year, int month) {
    if (month == 2) {
      // 2월은 윤년 여부에 따라 일수가 달라집니다.
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        // 윤년인 경우 29일
        return 29;
      } else {
        // 윤년이 아닌 경우 28일
        return 28;
      }
    } else {
      // 각 월의 일수를 반환합니다.
      List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      return daysInMonth[month - 1];
    }
  }
}