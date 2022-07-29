class HelperKitsModel {
  String familyId;
  String familyMembersNumber;
  String familyLocation;
  String phoneNumber;

  HelperKitsModel(
      {required this.familyId,
      required this.familyMembersNumber,
      required this.familyLocation,
      required this.phoneNumber});

  Map<String, dynamic> toJson() => {
        'familyID': familyId,
        'familyMembersNumber': familyMembersNumber,
        'familyLocation': familyLocation,
        'phone_number': phoneNumber
      };

  static HelperKitsModel fromJson(Map<String, dynamic> json) => HelperKitsModel(
      familyId: json['familyID'],
      familyMembersNumber: json['familyMembersNumber'],
      familyLocation: json['familyLocation'],
      phoneNumber: json['phone_number']);
} // end class
