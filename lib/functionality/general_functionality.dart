class GeneralFunctionality {
  static String getBulanName(int bulan) {
    if (bulan == 1) {
      return 'Januari';
    } else if (bulan == 2) {
      return 'Februari';
    } else if (bulan == 3) {
      return 'Maret';
    } else if (bulan == 4) {
      return 'April';
    } else if (bulan == 5) {
      return 'Mei';
    } else if (bulan == 6) {
      return 'Juni';
    } else if (bulan == 7) {
      return 'Juli';
    } else if (bulan == 8) {
      return 'Agustus';
    } else if (bulan == 9) {
      return 'September';
    } else if (bulan == 10) {
      return 'Oktober';
    } else if (bulan == 11) {
      return 'November';
    } else if (bulan == 12) {
      return 'Desember';
    }
    return '';
  }

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

  static String tanggalIndonesia(String datetime) {
    final tanggal = datetime.substring(0, 10).split('-');
    String bulan = getBulanName(int.parse(tanggal[1]));
    return '${(int.parse(tanggal[2])).toString()} $bulan ${tanggal[0]}';
  }

  static String timeStampToTanggalIndo(String timeStamp) {
    final timeStampSplitted = timeStamp.split('T');
    final tanggal = timeStampSplitted[0].split('-');
    final jam = timeStampSplitted[1].split(':');
    return '${tanggal[2]}/${tanggal[1]}/${tanggal[0]}, ${jam[0]}:${jam[1]}';
  }
}
