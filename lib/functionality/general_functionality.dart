class GeneralFunctionality {
  static String getBulanNameSingkatan(int bulan) {
    if (bulan == 1) {
      return 'Jan';
    } else if (bulan == 2) {
      return 'Feb';
    } else if (bulan == 3) {
      return 'Mar';
    } else if (bulan == 4) {
      return 'Apr';
    } else if (bulan == 5) {
      return 'Mei';
    } else if (bulan == 6) {
      return 'Jun';
    } else if (bulan == 7) {
      return 'Jul';
    } else if (bulan == 8) {
      return 'Agus';
    } else if (bulan == 9) {
      return 'Sep';
    } else if (bulan == 10) {
      return 'Okt';
    } else if (bulan == 11) {
      return 'Nov';
    } else if (bulan == 12) {
      return 'Des';
    }
    return '';
  }
}
