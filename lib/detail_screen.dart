// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously
import 'dart:core';
import 'dart:convert';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:calegmu/component/caleg_pendidikan_component.dart';
import 'package:calegmu/component/caleg_pengalaman_component.dart';
import 'package:calegmu/component/caleg_tentang_component.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late int userId;
  late String nama;
  late String gambar;
  late String? partai;
  late String? dapil;
  late String? tingkat;
  late int? paketId;
  late bool isFinalisation;
  late bool isActive;
  late int nomorUrut;
  late String? provinsi;
  late double? rating;
  late int ratingGiven;
  late int ratingTemp;
  late String? tentang;
  late bool _isLoading;
  late final TabController tabController;
  late List<dynamic> listLink;
  late List<dynamic> listYoutube;
  late List<dynamic> pengalaman;
  late List<dynamic> pendidikan;
  late dynamic profile;
  late String? token;
  late Widget? tabCurrent;
  late int key;

  Future<void> getCaleg() async {
    if (mounted) setState(() => _isLoading = true);
    final response = await http.get(
      Uri.parse("https://backend.calegmu.com/caleg/calegId/${widget.id}"),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      if (mounted) {
        setState(() {
          userId = responseBody['auth']['id'];
          isFinalisation = responseBody['isFinalisation'] ?? false;
          isActive = responseBody['auth']['isActive'];
          paketId = responseBody['paketId'];
          nama =
              "${responseBody['auth']['namaDepan']}${responseBody['auth']['namaBelakang'] != null ? ' ${responseBody['auth']['namaBelakang']}' : ''}";
          tingkat = responseBody['tingkat'];
          gambar = "https://backend.calegmu.com/account/foto-profil/${responseBody['auth']['gambar']}";
          partai = responseBody['partai'] == null || responseBody['partai']['namaLengkap'] == null ? '' : responseBody['partai']['namaLengkap'];
          dapil = responseBody['dapil']['nama'];
          nomorUrut = responseBody['nomorUrut'];
          tentang = responseBody['tentang'] ?? '';
          rating = double.parse(responseBody['ratingnya'].toString());

          if (responseBody['dapil'] != null)
            provinsi = responseBody['dapil']['tingkat'] == 'RI' ||
                    responseBody['dapil']['tingkat'] == 'Daerah' ||
                    responseBody['dapil']['tingkat'] == 'Provinsi'
                ? responseBody['dapil']['provinsi']['namaId'] ?? responseBody['dapil']['provinsi']['nama']
                : responseBody['dapil']['kabupaten']['provinsi']['namaId'] ?? responseBody['dapil']['kabupaten']['provinsi']['nama'];

          pengalaman = responseBody['pengalaman'];
          pendidikan = responseBody['pendidikan'];
          listYoutube = responseBody['youtube'];
          listLink = responseBody['link'];
          tabCurrent = _getTabAtIndex(tabController.index);
        });
      }
    }

    getLink();
  }

  Future<List<dynamic>> fetchFavicons(List<dynamic> listLink) async {
    List<Future<dynamic>> futures = listLink.map((val) async {
      try {
        val['image'] = (await FaviconFinder.getBest(val['link']))!.url;
      } catch (e) {
        val['image'] = 'https://backend.calegmu.com/account/foto-profil/default.png';
      }
      return val;
    }).toList();

    return Future.wait(futures);
  }

  Future<void> getLink() async {
    List<dynamic> tempLink = await fetchFavicons(listLink);

    if (mounted) {
      setState(() {
        listLink = [];
        listLink.addAll(tempLink);
      });
    }
    Future.delayed(const Duration(milliseconds: 700), () => mounted ? setState(() => _isLoading = false) : null);
  }

  @override
  void initState() {
    super.initState();
    userId = 0;
    gambar = 'https://backend.calegmu.com/account/foto-profil/default.png';
    partai = '';
    dapil = '';
    isFinalisation = false;
    isActive = false;
    paketId = null;
    nama = '';
    tingkat = '';
    provinsi = '';
    tentang = '';
    rating = 0;
    ratingGiven = 0;
    ratingTemp = 0;
    nomorUrut = 0;
    listLink = [];
    listYoutube = [];
    pengalaman = [];
    pendidikan = [];
    _isLoading = true;
    key = 1;
    tabController = TabController(length: 3, vsync: this);
    tabCurrent = null;
    profile = null;
    token = null;

    getCaleg();
    tabCurrent = _getTabAtIndex(tabController.index);
    tabController.addListener(() {
      if (mounted) setState(() => tabCurrent = _getTabAtIndex(tabController.index));
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget? _getTabAtIndex(int index) {
    var list = [
      CalegTentangComponent(
        listLink: listLink,
        listYoutube: listYoutube,
        tentang: tentang,
      ),
      CalegPengalamanComponent(
        pengalaman: pengalaman,
        id: widget.id,
      ),
      CalegPendidikanComponent(
        pendidikan: pendidikan,
        id: widget.id,
      ),
    ];
    return list[index];
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: DefaultTabController(
                length: 3,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              ClipOval(
                                child: Image.network(
                                  gambar,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => const Icon(Icons.error, size: 10),
                                  width: 85,
                                  height: 85,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text.rich(
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${nomorUrut.toString()}. $nama',
                                      style: const TextStyle(fontSize: 15, color: Color(0xFF1A1D1F), fontWeight: FontWeight.bold),
                                    ),
                                    if (isFinalisation == true) const WidgetSpan(child: SizedBox(width: 5)),
                                    if (isFinalisation == true && isActive == true)
                                      WidgetSpan(child: Icon(Icons.verified, color: Color(paketId != null ? 0xFFFFCF40 : 0xFF4169E1), size: 18))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '$partai${partai != null && partai != '' ? ' - ' : ''}$dapil',
                                style: const TextStyle(color: Color(0xFF000000), fontSize: 13),
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                              ),
                              const SizedBox(height: 7),
                              Text(
                                ' ${provinsi != null ? '${provinsi ?? ''} - ' : ''}$tingkat',
                                style: const TextStyle(color: Color(0xFF6C6C6C), fontSize: 12.8),
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    rating! >= 1 ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 30,
                                    color: Colors.yellow[600],
                                  ),
                                  Icon(
                                    rating! >= 2 ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 30,
                                    color: Colors.yellow[600],
                                  ),
                                  Icon(
                                    rating! >= 3 ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 30,
                                    color: Colors.yellow[600],
                                  ),
                                  Icon(
                                    rating! >= 4 ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 30,
                                    color: Colors.yellow[600],
                                  ),
                                  Icon(
                                    rating! == 5 ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 30,
                                    color: Colors.yellow[600],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded, size: 24),
                          ),
                        ),
                      ],
                    ),
                    if (!_isLoading)
                      TabBar(
                        isScrollable: true,
                        controller: tabController,
                        labelColor: const Color(0xFFFF8A3C),
                        unselectedLabelColor: Colors.black,
                        indicatorColor: const Color(0xFFFF8A3C),
                        labelStyle: TextStyle(fontSize: 12.5 / scaleFactor),
                        tabs: const [
                          Tab(text: 'Tentang'),
                          Tab(text: 'Pengalaman'),
                          Tab(text: 'Pendidikan'),
                        ],
                      ),
                    if (!_isLoading && tabCurrent != null) tabCurrent!,
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Opacity(
                opacity: 0.2,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
