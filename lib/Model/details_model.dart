class DetailModel {
  String? id;
  String? startDate;
  String? endDate;
  String? trips;
  String? amount;
  String? driverId;
  String? count;
  String? complteSta;

  DetailModel(
      {this.id,
        this.startDate,
        this.endDate,
        this.trips,
        this.amount,
        this.driverId,
        this.count,
        this.complteSta});

  DetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    trips = json['trips'];
    amount = json['amount'];
    driverId = json['driver_id'];
    count = json['count'];
    complteSta = json['complte_sta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['trips'] = this.trips;
    data['amount'] = this.amount;
    data['driver_id'] = this.driverId;
    data['count'] = this.count;
    data['complte_sta'] = this.complteSta;
    return data;
  }
}
