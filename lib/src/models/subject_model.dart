class SubjectModel {
  int idS;
  String subjectName;
  int idA;
  double primerCorte;
  double segundoCorte;
  double tecerCorte;
  double definitiva;

  SubjectModel({
    this.idS,
    this.subjectName,
    this.primerCorte,
    this.segundoCorte,
    this.tecerCorte,
    this.idA,
    this.definitiva,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => new SubjectModel(
        idS: json["idS"],
        subjectName: json["subjectName"],
        primerCorte: json["primerCorte"],
        segundoCorte: json["segundoCorte"],
        tecerCorte: json["tecerCorte"],
        idA: json["idA"],
        definitiva: json["definitiva"],
      );

  Map<String, dynamic> toJson() => {
        "idS": idS,
        "subjectName": subjectName,
        "primerCorte": primerCorte,
        "segundoCorte": segundoCorte,
        "tecerCorte": tecerCorte,
        "idA": idA,
        "definitiva": definitiva,
      };
}
