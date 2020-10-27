// To parse this JSON data, do
//
//     final azkar = azkarFromJson(jsonString);

import 'dart:convert';

List<Azkar> azkarFromJson(String str) =>
    List<Azkar>.from(json.decode(str).map((x) => Azkar.fromJson(x)));

String azkarToJson(List<Azkar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Azkar {
  Azkar({
    this.category,
    this.count,
    this.description,
    this.reference,
    this.zekr,
  });

  String category;
  String count;
  String description;
  Reference reference;
  String zekr;

  factory Azkar.fromJson(Map<String, dynamic> json) => Azkar(
        category: json["category"],
        count: json["count"],
        description: json["description"],
        reference: referenceValues.map[json["reference"]],
        zekr: json["zekr"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "count": count,
        "description": description,
        "reference": referenceValues.reverse[reference],
        "zekr": zekr,
      };
}

enum Reference {
  THE_255,
  EMPTY,
  REFERENCE,
  PURPLE,
  FLUFFY,
  TENTACLED,
  STICKY,
  INDIGO,
  INDECENT,
  HILARIOUS,
  AMBITIOUS,
  CUNNING,
  MAGENTA,
  THE_285286,
  FRISKY,
  MISCHIEVOUS
}

final referenceValues = EnumValues({
  "الترمذي": Reference.AMBITIOUS,
  "": Reference.CUNNING,
  "سورة الإخلاص": Reference.EMPTY,
  "مسلم": Reference.FLUFFY,
  "أحمد\n": Reference.FRISKY,
  "ابن ماجة": Reference.HILARIOUS,
  "أبن السني": Reference.INDECENT,
  "أبو داود": Reference.INDIGO,
  "الطبراني": Reference.MAGENTA,
  "البخاري\n": Reference.MISCHIEVOUS,
  "سورة الناس": Reference.PURPLE,
  "سورة الفلق": Reference.REFERENCE,
  "أحمد": Reference.STICKY,
  "البخاري": Reference.TENTACLED,
  "[آية الكرسى - البقرة 255].": Reference.THE_255,
  "[البقرة 285 - 286].": Reference.THE_285286
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
