import 'package:flutter_test/flutter_test.dart';
import 'package:recycle_extension/recycle_extension.dart';

void main() {
  // DateTime Extension
  group('DateTimeExtension', () {
    test('isBetween() 지정한 startDate와 endDate 사이에 있는 날짜인지 확인한다.', () {
      final DateTime now = DateTime.now();
      expect(now.isBetween(now.subtract(const Duration(days: 1)), now), true);
      expect(now.isBetween(now, now.add(const Duration(days: 1))), true);
      expect(now.isBetween(now.add(const Duration(days: 1)), now.subtract(const Duration(days: 1))), false);
      expect(now.isBetween(now, now.subtract(const Duration(days: 1))), false);
      expect(now.isBetween(DateTime(2000), DateTime(9999)), true);
    });
    test('getStartOfMonth() 월초를 구한다.', () {
      final DateTime now = DateTime.now();
      expect(now.getStartOfMonth().day, 1);
      expect(now.getStartOfMonth().month, DateTime.now().month);
      expect(now.getStartOfMonth().year, DateTime.now().year);
    });
    test('getEndOfMonth() 월말를 구한다.', () {
      final DateTime now = DateTime.now();
      expect(now.getEndOfMonth().day, greaterThanOrEqualTo(DateTime.now().day));
      expect(now.getEndOfMonth().day, greaterThanOrEqualTo(28));
      expect(now.getEndOfMonth().month, DateTime.now().month);
      expect(now.getEndOfMonth().year, DateTime.now().year);
    });
    test(
      'previousMonth() 한달 전 날짜를 출력한다.',
          () {
        DateTime dateTime = DateTime(2024, 1, 31);
        expect(dateTime.previousMonth, DateTime(2023, 12, 31));
        dateTime = DateTime(2024, 3, 31);
        expect(dateTime.previousMonth, DateTime(2024, 2, 29));
        dateTime = DateTime(2025, 4, 4);
        expect(dateTime.previousMonth, DateTime(2025, 3, 4));
      },
    );
    test(
      'nextMonth() 한달 후 날짜를 출력한다.',
          () {
        DateTime dateTime = DateTime(2023, 12, 31);
        expect(dateTime.nextMonth, DateTime(2024, 1, 31));
        dateTime = DateTime(2024, 2, 29);
        expect(dateTime.nextMonth, DateTime(2024, 3, 29));
        dateTime = DateTime(2025, 5, 31);
        expect(dateTime.nextMonth, DateTime(2025, 6, 30));
      },
    );
    test('dateForCurrentLocale 형식을 확인한다.', () {
      DateTime dateTime = DateTime(2024, 3, 12);
      String formattedDate = dateTime.dateForCurrentLocale;
      expect(formattedDate, '03, 12, 2024');
    });
    test('yyyyMMdd 포맷으로 출력되어야한다.', () {
      DateTime dateTime = DateTime(2024, 3, 12);
      String formattedDate = dateTime.yyyyMMdd;
      expect(formattedDate, '2024-03-12');
    });
    test('yyMMdd 포맷으로 출력되어야한다.', () {
      DateTime dateTime = DateTime(1999, 3, 12);
      String formattedDate = dateTime.yyMMdd;
      expect(formattedDate, '99-03-12');
    });
    test('yyyyMMddHHmmss 포맷으로 출력되어야한다.', () {
      DateTime dateTime = DateTime(2024, 3, 12, 14, 30, 45);
      String formattedDateTime = dateTime.yyyyMMddHHmmss;
      expect(formattedDateTime, '2024-03-12 14:30:45');
    });
    test('yyyyMMddTHHmmssSSS 포맷으로 출력되어야한다.', () {
      DateTime dateTime = DateTime(2024, 3, 12, 14, 30, 45, 999);
      String formattedDateTime = dateTime.yyyyMMddTHHmmssSSS;
      expect(formattedDateTime, '2024-03-12T14:30:45.999');
    });
  });

  group('Num Extension', () {
    test('숫자에 천단위 콤마기호가 잘 삽입되어야 한다.', () {
      int money = 123123123;
      expect(money.numberWithCommas(showDecimal: false), '123,123,123');

      double weight = 11012.57;
      expect(weight.numberWithCommas(), '11,012.57');

      double pi = 1113.1415926535;
      expect(pi.numberWithCommas(decimalDigit: 2), '1,113.14');

      double longValue = 101012123434.123123124214;
      expect(longValue.numberWithCommas(decimalDigit: 1), '101,012,123,434.1');
    });

    test('아스키코드를 숫자값으로 바꿔주고 유효하지 않은 값은 0으로 처리한다.', () {
      // 0 ~ 9 에 해당하는 아스키코드 리스트를 생성
      List<int> asciiCodeList = List.generate(10, (index) => index + 48);

      for (int i = 0; i < asciiCodeList.length; i++) {
        expect(asciiCodeList[i].convertASCII(), i);
      }

      // 유효하지않은(숫자가 아닌) 아스키코드
      int invalidAsciiCode = 65;
      expect(invalidAsciiCode.convertASCII(), 0);
    });

    test('double이 0의 값을 가질경우 소수점을 표기하지 않는다.', () {
      double zeroValue = 0.000;
      expect(zeroValue.toStringIfZero(), '0');
      double doubleValue = 1.234;
      expect(doubleValue.toStringIfZero(), doubleValue.toString());
    });
  });

  group('String Extension', () {
    test('콤마가 포함된 String을 int형으로 변환하고 오류시 0을 반환한다.', () {
      String money = '100,000';
      expect(money.removeCommaToInt, 100000);
    });
    test('콤마가 포함된 String에서 콤마를 제거한다.', () {
      String money = '10,000';
      expect(money.removeComma, '10000');
      String weight = '10,000,000.14';
      expect(weight.removeComma, '10000000.14');
    });
    test('사업자번호 양식에 맞게 변환해준다.', () {
      String businessNumber = '3140728395';
      expect(businessNumber.businessFormatted, '314-07-28395');

      String invalidBusinessNumber = '314072839';
      expect(invalidBusinessNumber.businessFormatted, '314072839');
    });
    test('사업자번호 양식에 맞게 변환해준다.', () {
      String businessNumber = '3140728395';
      expect(businessNumber.businessFormatted, '314-07-28395');

      String invalidBusinessNumber = '314072839';
      expect(invalidBusinessNumber.businessFormatted, '314072839');
    });
    test('RFID 시리얼 번호에 맞게 문자를 잘라야한다.', () {
      String rfid = 'asdlkfblklejkvbkjfbv23270006';
      expect(rfid.sliceRFID, '23270006');

      String invalidRfid = '1234';
      expect(invalidRfid.sliceRFID, '1234');
    });
    test('버전비교를 위해 버전을 숫자값으로 바꿔줘야한다.', () {
      String version1 = '1.12.1';
      expect(version1.convertVersion(), 1012001);
      String version2 = '100.2.11';
      expect(version2.convertVersion(), 100002011);
      String version3 = '1.0.0';
      expect(version3.convertVersion(), 1000000);
    });
    test('은/는을 단어에 맞게 붙여주어야 한다.', () {
      String word1 = '김치';
      expect(word1.completeEunNeun(), '김치는');
      String word2 = '치킨';
      expect(word2.completeEunNeun(), '치킨은');
    });
    test('을/를을 단어에 맞게 붙여주어야 한다.', () {
      String word1 = '김치';
      expect(word1.completeEulReul(), '김치를');
      String word2 = '치킨';
      expect(word2.completeEulReul(), '치킨을');
    });
    test('이/가를 단어에 맞게 붙여주어야 한다.', () {
      String word1 = '김치';
      expect(word1.completeIGa(), '김치가');
      String word2 = '치킨';
      expect(word2.completeIGa(), '치킨이');
    });
    test('uri의 가장 뒷부분에 해당하는 url을 가져와야 한다.', () {
      String uri = 'http://uco.test.recycleledger.com/uco/collection';
      expect(uri.parseUrl, 'collection');
    });
    test('double로 변환하고 오류시 기본값을 반환한다.', () {
      String doubleValue = '123.12';
      expect(doubleValue.toDoubleOrDefault(), 123.12);
      String? nullValue;
      expect(nullValue.toDoubleOrDefault(defaultValue: 1), 1);
      String invalidValue = '123kg';
      expect(invalidValue.toDoubleOrDefault(), 0.0);
    });
    test('int로 변환하고 오류시 기본값을 반환한다.', () {
      String intValue = '123';
      expect(intValue.toIntOrDefault(), 123);
      String? nullValue;
      expect(nullValue.toIntOrDefault(defaultValue: 1), 1);
      String invalidValue = '123kg';
      expect(invalidValue.toIntOrDefault(), 0);
    });
  });
}
