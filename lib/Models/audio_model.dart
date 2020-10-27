import 'dart:convert';

Audio souraFromJson(String str) => Audio.fromJson(json.decode(str));

String souraToJson(Audio data) => json.encode(data.toJson());

class Audio {
  Audio({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  DataAudio data;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        code: json["code"],
        status: json["status"],
        data: DataAudio.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class DataAudio {
  DataAudio({
    this.surahs,
    this.edition,
  });

  List<SurahAudio> surahs;
  EditionAudio edition;

  factory DataAudio.fromJson(Map<String, dynamic> json) => DataAudio(
        surahs: List<SurahAudio>.from(
            json["surahs"].map((x) => SurahAudio.fromJson(x))),
        edition: EditionAudio.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
        "surahs": List<dynamic>.from(surahs.map((x) => x.toJson())),
        "edition": edition.toJson(),
      };
}

class EditionAudio {
  EditionAudio({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;

  factory EditionAudio.fromJson(Map<String, dynamic> json) => EditionAudio(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: json["format"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": format,
        "type": type,
      };
}

class SurahAudio {
  SurahAudio({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  RevelationType revelationType;
  List<AyahAudio> ayahs;

  factory SurahAudio.fromJson(Map<String, dynamic> json) => SurahAudio(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: revelationTypeValues.map[json["revelationType"]],
        ayahs: List<AyahAudio>.from(
            json["ayahs"].map((x) => AyahAudio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationTypeValues.reverse[revelationType],
        "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
      };
}

class AyahAudio {
  AyahAudio({
    this.number,
    this.audio,
    this.audioSecondary,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  int number;
  String audio;
  List<String> audioSecondary;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  dynamic sajda;

  factory AyahAudio.fromJson(Map<String, dynamic> json) => AyahAudio(
        number: json["number"],
        audio: json["audio"],
        audioSecondary: List<String>.from(json["audioSecondary"].map((x) => x)),
        text: json["text"],
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "audio": audio,
        "audioSecondary": List<dynamic>.from(audioSecondary.map((x) => x)),
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
      };
}

class SajdaAudioClass {
  SajdaAudioClass({
    this.id,
    this.recommended,
    this.obligatory,
  });

  int id;
  bool recommended;
  bool obligatory;

  factory SajdaAudioClass.fromJson(Map<String, dynamic> json) =>
      SajdaAudioClass(
        id: json["id"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues(
    {"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

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
