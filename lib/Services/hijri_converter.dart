import '../Models/hijri_date.dart';

class HijriConverter {
  // Gregorian → JD
  static int gregorianToJD(int year, int month, int day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    int A = year ~/ 100;
    int B = 2 - A + (A ~/ 4);

    return (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        B -
        1524;
  }

  // JD → Hijri
  static HijriDate jdToHijri(int jd) {
    int l = jd - 1948440 + 10632;
    int n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;

    int j = ((10985 - l) ~/ 5316) *
            ((50 * l) ~/ 17719) +
        (l ~/ 5670) *
            ((43 * l) ~/ 15238);

    l = l -
        ((30 - j) ~/ 15) *
            ((17719 * j) ~/ 50) -
        (j ~/ 16) *
            ((15238 * j) ~/ 43) +
        29;

    int month = (24 * l) ~/ 709;
    int day = l - (709 * month) ~/ 24;
    int year = 30 * n + j - 30;

    return HijriDate(day: day, month: month, year: year);
  }

  // Hijri → JD

  static int hijriToJD(int year, int month, int day) {
    return (day +
            ((29.5 * (month - 1)).ceil()) +
            (year - 1) * 354 +
            ((3 + (11 * year)) ~/ 30) +
            1948440 -
            1);
  }

  // JD → Gregorian
  static DateTime jdToGregorian(int jd) {
    int l = jd + 68569;
    int n = (4 * l) ~/ 146097;
    l = l - (146097 * n + 3) ~/ 4;
    int i = (4000 * (l + 1)) ~/ 1461001;
    l = l - (1461 * i) ~/ 4 + 31;
    int j = (80 * l) ~/ 2447;
    int day = l - (2447 * j) ~/ 80;
    l = j ~/ 11;
    int month = j + 2 - 12 * l;
    int year = 100 * (n - 49) + i + l;

    return DateTime(year, month, day);
  }

  // =====================
  // Helper functions
  // =====================

  static HijriDate fromGregorian(DateTime date) {
    int jd = gregorianToJD(date.year, date.month, date.day);
    return jdToHijri(jd);
  }

  static DateTime toGregorian(HijriDate hijri) {
    int jd = hijriToJD(hijri.year, hijri.month, hijri.day);
    return jdToGregorian(jd);
  }
}