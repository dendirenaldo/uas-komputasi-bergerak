import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:calegmu/component/caleg_component.dart';

class CalegList extends StatefulWidget {
  const CalegList({Key? key}) : super(key: key);

  @override
  State<CalegList> createState() => _CalegListState();
}

class _CalegListState extends State<CalegList> {
  late final List<CalegComponent> listCaleg;

  Future<void> getCaleg() async {
    final http.Response response = await http.get(
      Uri.parse('https://backend.calegmu.com/caleg?offset=0&limit=20&filterIsOrderByRating=true&filterDapilId=2130&filterTingkat=DPR RI'),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<CalegComponent> tempCaleg = [];

      for (var data in responseBody['data']) {
        int terpilih = data['pemilihan'].length ?? 0;
        int jumlahPemilihan = data['jumlahPemilihan'];
        tempCaleg.add(
          CalegComponent(
            id: data['id'],
            nama: "${data['auth']['namaDepan']}${data['auth']['namaBelakang'] != null ? ' ${data['auth']['namaBelakang']}' : ''}",
            partai:
                "${data['partai'] == null || data['partai']['namaLengkap'] == null ? '' : '${data['partai']['namaLengkap']} - '}${data['dapil']['nama']}",
            gambar: "https://backend.calegmu.com/account/foto-profil/${data['auth']['gambar']}",
            provinsi: data['dapil']['tingkat'] != 'Kabupaten'
                ? data['dapil']['provinsi']['namaId'] ?? data['dapil']['provinsi']['nama']
                : data['dapil']['kabupaten']['provinsi']['namaId'] ?? data['dapil']['kabupaten']['provinsi']['nama'],
            polls: terpilih != 0 && jumlahPemilihan != 0 ? ((terpilih / jumlahPemilihan) * 100).ceil() : 0,
            nomorUrut: data['nomorUrut'],
            rating: double.parse(data['rating'].toString()),
            isFinalisation: data['isFinalisation'] == 1 ? true : false,
            isActive: data['auth']['isActive'] == 1 ? true : false,
            paketId: data['paketId'],
          ),
        );
      }

      if (mounted) setState(() => listCaleg.addAll(tempCaleg));
    }
  }

  @override
  void initState() {
    super.initState();
    listCaleg = [];
    getCaleg();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: listCaleg,
        ),
      ),
    );
  }
}
