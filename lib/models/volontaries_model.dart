class VoluntariesModel {
  String name;
  String phoneNumber;
  String email;
  String skills;
  String section;

  VoluntariesModel(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.skills,
      required this.section});
  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'skills': skills,
        'section': section
      };

  static VoluntariesModel fromJson(Map<String, dynamic> json) => VoluntariesModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      skills: json['skills'],
      section: json['section']);
}
