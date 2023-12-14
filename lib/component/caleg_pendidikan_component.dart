import 'package:flutter/material.dart';
import 'package:calegmu/functionality/general_functionality.dart';

class CalegPendidikanComponent extends StatelessWidget {
  final int id;
  final List<dynamic> pendidikan;

  const CalegPendidikanComponent({
    super.key,
    required this.id,
    required this.pendidikan,
  });

  List<Widget> listPendidikan(BuildContext context, double width) {
    final List<Widget> list = [];

    for (var i = 0; i < pendidikan.length; i++) {
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
                    pendidikan[i]['namaInstitusi'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.3),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pendidikan[i]['programStudi'],
                    style: const TextStyle(fontSize: 12),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${GeneralFunctionality.getBulanNameSingkatan(pendidikan[i]['bulanMulai'])} ${pendidikan[i]['tahunMulai']} ${pendidikan[i]['bulanBerakhir'] != null ? '- ${GeneralFunctionality.getBulanNameSingkatan(pendidikan[i]['bulanBerakhir'])} ${pendidikan[i]['tahunBerakhir']}' : ''}",
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6C6C6C)),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pendidikan[i]['lokasi'],
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6C6C6C)),
                    textScaleFactor: 1.0,
                  ),
                  if (i != pendidikan.length - 1) const SizedBox(height: 26),
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
      padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Pendidikan',
                style: TextStyle(fontSize: 14.5, color: Color(0xFF000000), fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
            ],
          ),
          const SizedBox(height: 18.5),
          ...listPendidikan(context, width),
          if (pendidikan.isEmpty)
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/vector_document.png',
                    width: width - 100,
                  ),
                  const Text(
                    'Tidak ada pendidikan',
                    style: TextStyle(fontSize: 13.5, color: Color(0xFF999999)),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
