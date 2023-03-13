class HistoryModel {
  String? walletId;
  String? driverId;
  String? userId;
  Null? bookingId;
  String? crDr;
  String? note;
  String? balance;
  String? mid;
  String? txnId;
  String? txnAmount;
  String? paymentMode;
  String? currency;
  String? txnDate;
  String? status;
  String? respcode;
  String? respmsg;
  String? gatewayName;
  String? bankTxnId;
  String? bankName;
  String? checksumhash;
  String? totalBalance;
  String? dateAdded;
  String? dateModified;
  String? incentiveStatus;
  String? numberTrips;
  String? fromDate;
  String? toDate;
  String? refferalStatus;
  String? incentiveId;
  String? incentiveBounusStatus;
  String? bookingTrip;
  String? adminPay;

  HistoryModel(
      {this.walletId,
        this.driverId,
        this.userId,
        this.bookingId,
        this.crDr,
        this.note,
        this.balance,
        this.mid,
        this.txnId,
        this.txnAmount,
        this.paymentMode,
        this.currency,
        this.txnDate,
        this.status,
        this.respcode,
        this.respmsg,
        this.gatewayName,
        this.bankTxnId,
        this.bankName,
        this.checksumhash,
        this.totalBalance,
        this.dateAdded,
        this.dateModified,
        this.incentiveStatus,
        this.numberTrips,
        this.fromDate,
        this.toDate,
        this.refferalStatus,
        this.incentiveId,
        this.incentiveBounusStatus,
        this.bookingTrip,
        this.adminPay});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    walletId = json['wallet_id'];
    driverId = json['driver_id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    crDr = json['cr_dr'];
    note = json['Note'];
    balance = json['balance'];
    mid = json['mid'];
    txnId = json['txn_id'];
    txnAmount = json['txn_amount'];
    paymentMode = json['payment_mode'];
    currency = json['currency'];
    txnDate = json['txn_date'];
    status = json['status'];
    respcode = json['respcode'];
    respmsg = json['respmsg'];
    gatewayName = json['gateway_name'];
    bankTxnId = json['bank_txn_id'];
    bankName = json['bank_name'];
    checksumhash = json['checksumhash'];
    totalBalance = json['total_balance'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    incentiveStatus = json['incentive_status'];
    numberTrips = json['number_trips'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    refferalStatus = json['refferal_status'];
    incentiveId = json['incentive_id'];
    incentiveBounusStatus = json['incentive_bounus_status'];
    bookingTrip = json['booking_trip'];
    adminPay = json['admin_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_id'] = this.walletId;
    data['driver_id'] = this.driverId;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['cr_dr'] = this.crDr;
    data['Note'] = this.note;
    data['balance'] = this.balance;
    data['mid'] = this.mid;
    data['txn_id'] = this.txnId;
    data['txn_amount'] = this.txnAmount;
    data['payment_mode'] = this.paymentMode;
    data['currency'] = this.currency;
    data['txn_date'] = this.txnDate;
    data['status'] = this.status;
    data['respcode'] = this.respcode;
    data['respmsg'] = this.respmsg;
    data['gateway_name'] = this.gatewayName;
    data['bank_txn_id'] = this.bankTxnId;
    data['bank_name'] = this.bankName;
    data['checksumhash'] = this.checksumhash;
    data['total_balance'] = this.totalBalance;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['incentive_status'] = this.incentiveStatus;
    data['number_trips'] = this.numberTrips;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['refferal_status'] = this.refferalStatus;
    data['incentive_id'] = this.incentiveId;
    data['incentive_bounus_status'] = this.incentiveBounusStatus;
    data['booking_trip'] = this.bookingTrip;
    data['admin_pay'] = this.adminPay;
    return data;
  }
}
