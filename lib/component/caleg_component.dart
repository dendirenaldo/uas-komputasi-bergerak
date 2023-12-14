// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:calegmu/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class CalegComponent extends StatefulWidget {
  final int id;
  final String nama;
  final String gambar;
  final String provinsi;
  final int polls;
  final int nomorUrut;
  final double rating;
  final bool isFinalisation;
  final bool isActive;
  final int? paketId;
  final String? partai;
  final bool? divider;

  const CalegComponent({
    super.key,
    required this.id,
    required this.nama,
    required this.gambar,
    required this.provinsi,
    required this.polls,
    required this.nomorUrut,
    required this.rating,
    required this.isFinalisation,
    required this.isActive,
    this.paketId,
    this.partai,
    this.divider,
  });

  @override
  State<CalegComponent> createState() => _CalegComponentState();
}

class _CalegComponentState extends State<CalegComponent> {
  String? namaLengkap;
  String? partai;
  String? tingkat;
  String? dapil;
  String? provinsi;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.divider == false && widget.divider != null ? 12 : 0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(id: widget.id)));
            },
            child: Ink(
              color: widget.divider == false && widget.divider != null ? Colors.grey[200] : Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: widget.divider == false && widget.divider != null ? 10 : 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: widget.gambar,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (BuildContext context, String url, dynamic error) => const Icon(Icons.error, size: 60),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 13),
                            SizedBox(
                              width: (width - (46 + 60 + 13)) * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Text.rich(
                                    textScaleFactor: 1.0,
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${widget.nomorUrut.toString()}. ${widget.nama}',
                                          style: const TextStyle(fontSize: 13, color: Color(0xFF001F25), fontWeight: FontWeight.bold),
                                        ),
                                        if (widget.isFinalisation == true) const WidgetSpan(child: SizedBox(width: 5)),
                                        if (widget.isFinalisation == true && widget.isActive == true)
                                          WidgetSpan(
                                            child: Icon(Icons.verified, color: Color(widget.paketId != null ? 0xFFFFCF40 : 0xFF4169E1), size: 15),
                                          )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  if (widget.partai != null)
                                    Text(
                                      widget.partai!,
                                      style: const TextStyle(fontSize: 11.8, color: Color(0xFF6C6C6C)),
                                      textScaleFactor: 1.0,
                                    ),
                                  if (widget.partai != null) const SizedBox(height: 5),
                                  Text(
                                    widget.provinsi,
                                    style: const TextStyle(fontSize: 11.8, color: Color(0xFF6C6C6C)),
                                    textScaleFactor: 1.0,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 23,
                              constraints: const BoxConstraints(minWidth: 60),
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  transform: GradientRotation(330.12 * 3.14 / 180),
                                  colors: [
                                    Color(0xFFFFA337),
                                    Color(0xFFFC6524),
                                  ],
                                  stops: [
                                    0.1153,
                                    0.8667,
                                  ],
                                ),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Center(
                                child: Text(
                                  "${widget.polls.toString()}% polls",
                                  style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  widget.rating >= 1 ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.yellow[600],
                                ),
                                Icon(
                                  widget.rating >= 2 ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.yellow[600],
                                ),
                                Icon(
                                  widget.rating >= 3 ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.yellow[600],
                                ),
                                Icon(
                                  widget.rating >= 4 ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.yellow[600],
                                ),
                                Icon(
                                  widget.rating == 5 ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.yellow[600],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.divider == true || widget.divider == null)
          const Divider(
            color: Color(0xB3E0DFDC),
            height: 2,
            thickness: 1,
          ),
      ],
    );
  }
}
