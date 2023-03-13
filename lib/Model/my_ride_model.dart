import 'package:sizer/sizer.dart';

class MyRideModel {
  String? id;
  String? userId;
  String? uneaqueId;
  String? purpose;
  String? pickupArea;
  String? pickupDate;
  String? dropArea;
  String? pickupTime;
  String? area;
  String? landmark;
  String? pickupAddress;
  String? dropAddress;
  String? taxiType;
  String? departureTime;
  String? departureDate;
  String? returnDate;
  String? flightNumber;
  String? package;
  String? promoCode;
  String? promoDiscount;
  String? distance;
  String? amount;
  String? paidAmount;
  String? address;
  String? transfer;
  String? itemStatus;
  String? transaction;
  String? paymentMedia;
  String? km;
  String? timetype;
  String? assignedFor;
  String? isPaidAdvance;
  String? status;
  String? latitude;
  String? longitude;
  String? dateAdded;
  String? dropLatitude;
  String? dropLongitude;
  String? bookingType;
  String? acceptReject;
  String? createdDate;
  String? username;
  String? reason;
  String? surgeAmount;
  String? gstAmount;
  String? bookingId;
  String? mobile;
  String? email;
  String? gender;
  String? dob;
  String? anniversaryDate;
  String? password;
  String? pickupadd;
  String? activeId;
  String? userStatus;
  String? resetId;
  String? walletAmount;
  String? deviceId;
  String? type;
  String? otp;
  String? userGcmCode;
  String? otpStatus;
  String? created;
  String? modified;
  String? userImage;
  String? userImage1;
  String? referralCode;
  String? friendsCode;
  String? longnitute;
  String? name;
  String? userName;
  String? phone;
  String? licenseNo;
  String? carTypeId;
  String? carType;
  String? carNo;
  String? modelNo;
  String? rating;
  String? prefferedLocation;
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
  String? bankName;
  String? accountNumber;
  String? bankCode;
  String? drivingLicencePhoto;
  String? onlineOfline;
  String? panCardStatus1;
  String? vehicalImegeStatus;
  String? aadharCardStatus;
  String? userImageStatus;
  String? panCardStatus;
  String? createdAt;
  String? profileStatus;
  String? dateOfBirth;
  String? incentiveStatus;
  String? incentiveDate;
  String? homeAddress;
  String? profileStatusRead;
  String? baseFare;
  String? ratePerKm;
  String? timeAmount;
  String? admin_commision;
  String? totalTime;
  String? bookingTime;
  String? hours;
  String? start_time,end_time;
  String? sharing_type;
  bool? show;
  MyRideModel(
      {this.id,
        this.hours,
        this.start_time,
        this.end_time,
        this.userId,
        this.uneaqueId,
        this.totalTime,
        this.purpose,
        this.pickupArea,
        this.pickupDate,
        this.dropArea,
        this.pickupTime,
        this.area,
        this.landmark,
        this.pickupAddress,
        this.dropAddress,
        this.taxiType,
        this.departureTime,
        this.departureDate,
        this.returnDate,
        this.flightNumber,
        this.package,
        this.promoCode,
        this.promoDiscount,
        this.distance,
        this.amount,
        this.paidAmount,
        this.address,
        this.transfer,
        this.itemStatus,
        this.transaction,
        this.paymentMedia,
        this.km,
        this.timetype,
        this.assignedFor,
        this.isPaidAdvance,
        this.status,
        this.latitude,
        this.longitude,
        this.dateAdded,
        this.dropLatitude,
        this.dropLongitude,
        this.bookingType,
        this.acceptReject,
        this.createdDate,
        this.username,
        this.reason,
        this.surgeAmount,
        this.gstAmount,
        this.bookingId,
        this.mobile,
        this.email,
        this.gender,
        this.dob,
        this.anniversaryDate,
        this.password,
        this.pickupadd,
        this.activeId,
        this.userStatus,
        this.resetId,
        this.walletAmount,
        this.deviceId,
        this.type,
        this.otp,
        this.userGcmCode,
        this.otpStatus,
        this.created,
        this.modified,
        this.userImage,
        this.referralCode,
        this.friendsCode,
        this.longnitute,
        this.name,
        this.userName,
        this.phone,
        this.licenseNo,
        this.carTypeId,
        this.carType,
        this.carNo,
        this.modelNo,
        this.rating,
        this.prefferedLocation,
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
        this.bankName,
        this.accountNumber,
        this.bankCode,
        this.drivingLicencePhoto,
        this.onlineOfline,
        this.panCardStatus1,
        this.vehicalImegeStatus,
        this.aadharCardStatus,
        this.userImageStatus,
        this.panCardStatus,
        this.createdAt,
        this.profileStatus,
        this.dateOfBirth,
        this.incentiveStatus,
        this.incentiveDate,
        this.homeAddress,
        this.bookingTime,
        this.userImage1,
        this.profileStatusRead,this.baseFare,this.ratePerKm,this.timeAmount,this.show,this.sharing_type,
        this.admin_commision});

  MyRideModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalTime = json['total_time'];
    sharing_type = json['shareing_type'];
    uneaqueId = json['uneaque_id'];
    purpose = json['purpose'];
    pickupArea = json['pickup_area'];
    pickupDate = json['pickup_date'];
    dropArea = json['drop_area'];
    pickupTime = json['pickup_time'];
    area = json['area'];
    hours = json['hours'];
    userImage1=json['user_image1'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    landmark = json['landmark'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    taxiType = json['taxi_type'];
    departureTime = json['departure_time'];
    departureDate = json['departure_date'];
    returnDate = json['return_date'];
    flightNumber = json['flight_number'];
    package = json['package'];
    promoCode = json['promo_code'];
    promoDiscount = json['promo_discount'];
    distance = json['distance'];
    amount = json['amount'];
    paidAmount = json['paid_amount'];
    address = json['address'];
    transfer = json['transfer'];
    itemStatus = json['item_status'];
    transaction = json['transaction'];
    paymentMedia = json['payment_media'];
    km = json['km'];
    timetype = json['timetype'];
    assignedFor = json['assigned_for'];
    isPaidAdvance = json['is_paid_advance'];
    status = json['status'];
    latitude = json['book_latitude']!=null?json['book_latitude']:json['latitude'];
    longitude = json['book_longitude']!=null?json['book_longitude']:json['longitude'];
    dateAdded = json['date_added'];
    dropLatitude = json['drop_latitude'];
    dropLongitude = json['drop_longitude'];
    bookingType = json['booking_type'];
    acceptReject = json['accept_reject'];
    createdDate = json['created_date'];
    username = json['username'];
    reason = json['reason'];
    surgeAmount = json['surge_amount'];
    gstAmount = json['gst_amount'];
    bookingId = json['booking_id'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    anniversaryDate = json['anniversary_date'];
    password = json['password'];
    pickupadd = json['pickupadd'];
    activeId = json['active_id'];
    userStatus = json['user_status'];
    resetId = json['reset_id'];
    walletAmount = json['wallet_amount'];
    deviceId = json['device_id'];
    type = json['type'];
    otp = json['otp'];
    userGcmCode = json['user_gcm_code'];
    otpStatus = json['otp_status'];
    created = json['created'];
    modified = json['modified'];
    userImage = json['user_image'];
    referralCode = json['referral_code'];
    friendsCode = json['friends_code'];
    longnitute = json['longnitute'];
    name = json['name'];
    userName = json['user_name'];
    phone = json['phone'];
    licenseNo = json['license_no'];
    carTypeId = json['car_type_id'];
    carType = json['car_type'];
    carNo = json['car_no'];
    modelNo = json['model_no'];
    rating = json['rating'];
    prefferedLocation = json['preffered_location'];
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
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    bankCode = json['bank_code'];
    drivingLicencePhoto = json['driving_licence_photo'];
    onlineOfline = json['online_ofline'];
    panCardStatus1 = json['pan_card_status1'];
    vehicalImegeStatus = json['vehical_imege_status'];
    aadharCardStatus = json['aadhar_card_status'];
    userImageStatus = json['user_image_status'];
    panCardStatus = json['pan_card_status'];
    createdAt = json['created_at'];
    profileStatus = json['profile_status'];
    dateOfBirth = json['date_of_birth'];
    incentiveStatus = json['incentive_status'];
    incentiveDate = json['incentive_date'];
    homeAddress = json['home_address'];
    profileStatusRead = json['profile_status_read'];
    baseFare = json['base_fare'];
    timeAmount = json['time_amount'];
    admin_commision = json['admin_commision'];
    ratePerKm = json['rate_per_km'];
    bookingTime = json['booking_time'];
    show = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['uneaque_id'] = this.uneaqueId;
    data['purpose'] = this.purpose;
    data['pickup_area'] = this.pickupArea;
    data['pickup_date'] = this.pickupDate;
    data['drop_area'] = this.dropArea;
    data['pickup_time'] = this.pickupTime;
    data['area'] = this.area;
    data['landmark'] = this.landmark;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['taxi_type'] = this.taxiType;
    data['departure_time'] = this.departureTime;
    data['departure_date'] = this.departureDate;
    data['return_date'] = this.returnDate;
    data['flight_number'] = this.flightNumber;
    data['package'] = this.package;
    data['promo_code'] = this.promoCode;
    data['promo_discount'] = this.promoDiscount;
    data['distance'] = this.distance;
    data['amount'] = this.amount;
    data['paid_amount'] = this.paidAmount;
    data['address'] = this.address;
    data['transfer'] = this.transfer;
    data['item_status'] = this.itemStatus;
    data['transaction'] = this.transaction;
    data['payment_media'] = this.paymentMedia;
    data['km'] = this.km;
    data['timetype'] = this.timetype;
    data['assigned_for'] = this.assignedFor;
    data['is_paid_advance'] = this.isPaidAdvance;
    data['status'] = this.status;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['date_added'] = this.dateAdded;
    data['drop_latitude'] = this.dropLatitude;
    data['drop_longitude'] = this.dropLongitude;
    data['booking_type'] = this.bookingType;
    data['accept_reject'] = this.acceptReject;
    data['created_date'] = this.createdDate;
    data['username'] = this.username;
    data['reason'] = this.reason;
    data['surge_amount'] = this.surgeAmount;
    data['gst_amount'] = this.gstAmount;
    data['booking_id'] = this.bookingId;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['anniversary_date'] = this.anniversaryDate;
    data['password'] = this.password;
    data['pickupadd'] = this.pickupadd;
    data['active_id'] = this.activeId;
    data['user_status'] = this.userStatus;
    data['reset_id'] = this.resetId;
    data['wallet_amount'] = this.walletAmount;
    data['device_id'] = this.deviceId;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['user_gcm_code'] = this.userGcmCode;
    data['otp_status'] = this.otpStatus;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['user_image'] = this.userImage;
    data['referral_code'] = this.referralCode;
    data['friends_code'] = this.friendsCode;
    data['longnitute'] = this.longnitute;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['phone'] = this.phone;
    data['license_no'] = this.licenseNo;
    data['car_type_id'] = this.carTypeId;
    data['car_type'] = this.carType;
    data['car_no'] = this.carNo;
    data['model_no'] = this.modelNo;
    data['rating'] = this.rating;
    data['preffered_location'] = this.prefferedLocation;
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
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['bank_code'] = this.bankCode;
    data['driving_licence_photo'] = this.drivingLicencePhoto;
    data['online_ofline'] = this.onlineOfline;
    data['pan_card_status1'] = this.panCardStatus1;
    data['vehical_imege_status'] = this.vehicalImegeStatus;
    data['aadhar_card_status'] = this.aadharCardStatus;
    data['user_image_status'] = this.userImageStatus;
    data['pan_card_status'] = this.panCardStatus;
    data['created_at'] = this.createdAt;
    data['profile_status'] = this.profileStatus;
    data['date_of_birth'] = this.dateOfBirth;
    data['incentive_status'] = this.incentiveStatus;
    data['incentive_date'] = this.incentiveDate;
    data['home_address'] = this.homeAddress;
    data['profile_status_read'] = this.profileStatusRead;
    data['booking_time'] = this.bookingTime;
    return data;
  }
}
