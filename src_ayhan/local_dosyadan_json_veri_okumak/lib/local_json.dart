import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_dosyadan_json_veri_okumak/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  late final Future<List<Araba>> _listeyiDoldur;

  @override
  void initState() {
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    arabalarJsonOku();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local Kısmı'),
        ),
        body: FutureBuilder<List<Araba>>(
            future: _listeyiDoldur,
            initialData: [
              Araba(arabaAdi: "egea", kurulusYil: 2018, ulke: "italya", model: [
                Model(modelSerisi: "a", fiyat: 200000, benzinliMi: true)
              ])
            ],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Araba> arabaListesi = snapshot.data!;
                return ListView.builder(
                    itemCount: arabaListesi.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(arabaListesi[index].arabaAdi),
                        subtitle: Text(arabaListesi[index].ulke),
                        leading: CircleAvatar(
                            child: Text(
                                arabaListesi[index].model[0].fiyat.toString())),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<List<Araba>> arabalarJsonOku() async {
    try {
      debugPrint("5 saniyelik işlem başlıyor");
      await Future.delayed(const Duration(seconds: 5), () {
        debugPrint("5 saniyelik işlem bitti");
      });
      String okunanString = await DefaultAssetBundle.of(context)
          .loadString("assets/data/arabalar.json");
      var jsonArray = jsonDecode(okunanString);
      //List arabaListesi = jsonArray;
      //debugPrint(arabaListesi[1]["model"][1].toString());
      List<Araba> tumArabalar = (jsonArray as List)
          .map((arabaMap) => Araba.fromMap(arabaMap))
          .toList();
      debugPrint(tumArabalar.length.toString());
      //debugPrint(okunanString);
      return tumArabalar;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
