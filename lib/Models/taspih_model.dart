class taspih {
  String Text;
  taspih({Text});
  factory taspih.fromJson(Map<String, dynamic> json) => taspih(
        Text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "Text": Text,
      };
}
