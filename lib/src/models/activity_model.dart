class ActivityModel {
  int idA;
  String activityName;
  double activityNote;
  int percent;
  int corte;


  ActivityModel({
    this.idA,
    this.activityName,
    this.activityNote,
    this.percent,
    this.corte,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      new ActivityModel(
        idA: json["idA"],
        activityName: json["activityName"],
        activityNote: json["activityNote"] / 1,
        percent: json["percent"],
        corte: json["corte"],
      );

  Map<String, dynamic> toJson() => {
        "idA": idA,
        "activityName": activityName,
        "activityNote": activityNote,
        "percent": percent,
        "corte": corte,
      };
}
