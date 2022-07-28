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
        'familyId': familyId,
        'familyMembersNumber': familyMembersNumber,
        'familyLocation': familyLocation,
        'phoneNumber': phoneNumber
      };

  static HelperKitsModel fromJson(Map<String, dynamic> json) => HelperKitsModel(
      familyId: json['familyId'],
      familyMembersNumber: json['familyMembersNumber'],
      familyLocation: json['familyLocation'],
      phoneNumber: json['phoneNumber']);
} // end class
