// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CalegTentangComponent extends StatelessWidget {
  final String? tentang;
  final List<dynamic>? listLink;
  final List<dynamic>? listYoutube;

  const CalegTentangComponent({
    super.key,
    this.tentang,
    this.listLink,
    this.listYoutube,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tentang Saya',
            style: TextStyle(fontSize: 14.5, color: Color(0xFF000000), fontWeight: FontWeight.bold),
            textScaleFactor: 1.0,
          ),
          const SizedBox(height: 21),
          Html(
            data: tentang ?? '',
            style: {
              "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
              "p": Style(margin: const EdgeInsets.only(bottom: 10), padding: EdgeInsets.zero),
            },
            onLinkTap: (url, _, __, ___) async => await launchUrl(
              Uri.parse(url!),
              mode: LaunchMode.externalApplication,
            ),
          ),
          const SizedBox(height: 30),
          if (listLink!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Link',
                  style: TextStyle(fontSize: 14.5, color: Color(0xFF000000), fontWeight: FontWeight.bold),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
          if (listLink!.isNotEmpty)
            Column(
              children: listLink!
                  .map((item) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: width - 60,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                if (await canLaunchUrl(Uri.parse(item['link']))) {
                                  await launchUrl(Uri.parse(item['link']), mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    item['image'] ?? 'https://backend.calegmu.com/account/foto-profil/default.png',
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) =>
                                        const Icon(Icons.error, size: 20),
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width - 90,
                                    child: Text(item['judul'] ?? item['link']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          if (listLink!.isNotEmpty) const SizedBox(height: 30),
          if (listYoutube!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Video Dokumentasi',
                  style: TextStyle(fontSize: 14.5, color: Color(0xFF000000), fontWeight: FontWeight.bold),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
          if (listYoutube!.isNotEmpty)
            ...(listYoutube!.map(
              (val) => Column(
                key: ValueKey('${key.toString()}_${val['id']}'),
                children: [
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () => launchUrl(Uri.parse(val['url']), mode: LaunchMode.externalApplication),
                    child: Ink(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            children: [
                              Image.network(
                                'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(val['url'])}/0.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.play_circle_rounded, size: 40, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }
}
