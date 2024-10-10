import 'package:flutter/material.dart';
import 'package:gaduan/models/penerima.dart';

class Person extends StatelessWidget {
  const Person({super.key, required this.dataPenerima});
  final PenerimaModel dataPenerima;

  createListPenerima() {
    String female_avater = 'assets/images/female_profile_placeholder.jpg';
    String male_avater = 'assets/images/male_profile_placeholder.jpg';
    List<Widget> penerima = [];
    dataPenerima.data?.forEach((data) {
      penerima.add(
        GestureDetector(
          onTap: () {}, // choose image on click of profile
          child: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  CircleAvatar(
                    minRadius: 20,
                    maxRadius: 30,
                    backgroundImage: ExactAssetImage(
                        data.jenisKelamin == 1 ? male_avater : female_avater),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(formatNama(data.nama!),
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 11)),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      );
    });
    return penerima;
  }

  formatNama(String nama) {
    var bagiNama = nama.split(' ');
    return bagiNama.length > 1 ? bagiNama[0] : bagiNama.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 8, 0, 8),
      child: ListView(
          scrollDirection: Axis.horizontal, children: createListPenerima()),
    );
  }
}
