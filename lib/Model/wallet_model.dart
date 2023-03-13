class WalletModel {
  String? walletId;
  String? driverId;
  String? userId;
  String? bookingId;
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
  String? dateAdded;
  String? dateModified;
  String? id;
  String? name;
  String? userName;
  String? password;
  String? phone;
  String? address;
  String? email;
  String? licenseNo;
  String? carTypeId;
  String? carType;
  String? carNo;
  String? gender;
  String? dob;
  String? anniversaryDate;
  String? walletAmount;
  String? activeId;
  String? userStatus;
  String? type;
  String? modelNo;
  String? rating;
  String? latitude;
  String? longitude;
  String? timetype;
  String? prefferedLocation;
  String? deviceId;
  String? permitNo;
  String? insuranceNo;
  String? isVerified;
  String? isActive;
  String? isBlock;
  String? drivingLicenceNo;
  String? panCard;
  String? aadharCard;
  String? vehicalImege;
  String? carModel;
  String? otp;
  String? accountNumber;
  String? bankCode;
  String? userGcmCode;
  String? userImage;
  String? drivingLicencePhoto;
  String? referralCode;
  String? friendsCode;
  String? onlineOfline;
  String? panCardStatus1;
  String? vehicalImegeStatus;
  String? aadharCardStatus;
  String? userImageStatus;
  String? panCardStatus;
  String? createdAt;
  String? profileStatus;
  String? time;

  WalletModel(
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
        this.dateAdded,
        this.dateModified,
        this.id,
        this.name,
        this.userName,
        this.password,
        this.phone,
        this.address,
        this.email,
        this.licenseNo,
        this.carTypeId,
        this.carType,
        this.carNo,
        this.gender,
        this.dob,
        this.anniversaryDate,
        this.walletAmount,
        this.activeId,
        this.userStatus,
        this.type,
        this.modelNo,
        this.rating,
        this.latitude,
        this.longitude,
        this.timetype,
        this.prefferedLocation,
        this.deviceId,
        this.permitNo,
        this.insuranceNo,
        this.isVerified,
        this.isActive,
        this.isBlock,
        this.drivingLicenceNo,
        this.panCard,
        this.aadharCard,
        this.vehicalImege,
        this.carModel,
        this.otp,
        this.accountNumber,
        this.bankCode,
        this.userGcmCode,
        this.userImage,
        this.drivingLicencePhoto,
        this.referralCode,
        this.friendsCode,
        this.onlineOfline,
        this.panCardStatus1,
        this.vehicalImegeStatus,
        this.aadharCardStatus,
        this.userImageStatus,
        this.panCardStatus,
        this.createdAt,
        this.time,
        this.profileStatus});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    licenseNo = json['license_no'];
    carTypeId = json['car_type_id'];
    carType = json['car_type'];
    carNo = json['car_no'];
    gender = json['gender'];
    dob = json['dob'];
    anniversaryDate = json['anniversary_date'];
    walletAmount = json['wallet_amount'];
    activeId = json['active_id'];
    userStatus = json['user_status'];
    type = json['type'];
    modelNo = json['model_no'];
    rating = json['rating'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timetype = json['timetype'];
    prefferedLocation = json['preffered_location'];
    deviceId = json['device_id'];
    permitNo = json['permit_no'];
    insuranceNo = json['insurance_no'];
    isVerified = json['is_verified'];
    isActive = json['is_active'];
    isBlock = json['is_block'];
    drivingLicenceNo = json['driving_licence_no'];
    panCard = json['pan_card'];
    aadharCard = json['aadhar_card'];
    vehicalImege = json['vehical_imege'];
    carModel = json['car_model'];
    otp = json['otp'];
    accountNumber = json['account_number'];
    bankCode = json['bank_code'];
    userGcmCode = json['user_gcm_code'];
    userImage = json['user_image'];
    drivingLicencePhoto = json['driving_licence_photo'];
    referralCode = json['referral_code'];
    friendsCode = json['friends_code'];
    onlineOfline = json['online_ofline'];
    panCardStatus1 = json['pan_card_status1'];
    vehicalImegeStatus = json['vehical_imege_status'];
    aadharCardStatus = json['aadhar_card_status'];
    userImageStatus = json['user_image_status'];
    panCardStatus = json['pan_card_status'];
    createdAt = json['created_at'];
    profileStatus = json['profile_status'];
    time = json['time'];
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
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['license_no'] = this.licenseNo;
    data['car_type_id'] = this.carTypeId;
    data['car_type'] = this.carType;
    data['car_no'] = this.carNo;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['anniversary_date'] = this.anniversaryDate;
    data['wallet_amount'] = this.walletAmount;
    data['active_id'] = this.activeId;
    data['user_status'] = this.userStatus;
    data['type'] = this.type;
    data['model_no'] = this.modelNo;
    data['rating'] = this.rating;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timetype'] = this.timetype;
    data['preffered_location'] = this.prefferedLocation;
    data['device_id'] = this.deviceId;
    data['permit_no'] = this.permitNo;
    data['insurance_no'] = this.insuranceNo;
    data['is_verified'] = this.isVerified;
    data['is_active'] = this.isActive;
    data['is_block'] = this.isBlock;
    data['driving_licence_no'] = this.drivingLicenceNo;
    data['pan_card'] = this.panCard;
    data['aadhar_card'] = this.aadharCard;
    data['vehical_imege'] = this.vehicalImege;
    data['car_model'] = this.carModel;
    data['otp'] = this.otp;
    data['account_number'] = this.accountNumber;
    data['bank_code'] = this.bankCode;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_image'] = this.userImage;
    data['driving_licence_photo'] = this.drivingLicencePhoto;
    data['referral_code'] = this.referralCode;
    data['friends_code'] = this.friendsCode;
    data['online_ofline'] = this.onlineOfline;
    data['pan_card_status1'] = this.panCardStatus1;
    data['vehical_imege_status'] = this.vehicalImegeStatus;
    data['aadhar_card_status'] = this.aadharCardStatus;
    data['user_image_status'] = this.userImageStatus;
    data['pan_card_status'] = this.panCardStatus;
    data['created_at'] = this.createdAt;
    data['profile_status'] = this.profileStatus;
    data['time'] = this.time;
    return data;
  }
}
