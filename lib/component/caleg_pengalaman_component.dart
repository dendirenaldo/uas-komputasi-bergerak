import 'package:flutter/material.dart';
import 'package:calegmu/functionality/general_functionality.dart';

class CalegPengalamanComponent extends StatelessWidget {
  final int id;
  final List<dynamic> pengalaman;

  const CalegPengalamanComponent({
    super.key,
    required this.id,
    required this.pengalaman,
  });

  List<Widget> listPengalaman(BuildContext context, double width) {
    final List<Widget> list = [];

    for (var i = 0; i < pengalaman.length; i++) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (width - 70) * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengalaman[i]['posisi'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.33),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pengalaman[i]['namaPerusahaan'],
                    style: const TextStyle(fontSize: 12),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${GeneralFunctionality.getBulanNameSingkatan(pengalaman[i]['bulanMulai'])} ${pengalaman[i]['tahunMulai']} ${pengalaman[i]['bulanBerakhir'] != null ? '- ${GeneralFunctionality.getBulanNameSingkatan(pengalaman[i]['bulanBerakhir'])} ${pengalaman[i]['tahunBerakhir']}' : ''}",
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6C6C6C)),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pengalaman[i]['lokasi'],
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6C6C6C)),
                    textScaleFactor: 1.0,
                  ),
                  if (i != pengalaman.length - 1) const SizedBox(height: 26),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Pengalaman',
                style: TextStyle(fontSize: 14.5, color: Color(0xFF000000), fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
            ],
          ),
          const SizedBox(height: 18.5),
          ...listPengalaman(context, width),
          if (pengalaman.isEmpty)
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/vector_document.png',
                    width: width - 100,
                  ),
                  const Text(
                    'Tidak ada pengalaman',
                    style: TextStyle(fontSize: 13.5, color: Color(0xFF999999)),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
