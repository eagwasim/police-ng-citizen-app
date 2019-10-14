import 'package:police_citizen_app/protocols/json-serializeable.dart';

class User extends JSONSerializable<User> {
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String bvn;
  String nin;
  String profilePhoto;
  String houseAddress;

  User({this.firstName, this.lastName, this.phoneNumber, this.bvn, this.nin, this.profilePhoto, this.houseAddress, this.emailAddress});

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'] ?? null,
        lastName = json['last_name'] ?? null,
        phoneNumber = json['phone_number'] ?? null,
        bvn = json['bvn'] ?? null,
        nin = json['nin'] ?? null,
        profilePhoto = json['profile_photo'] ?? null,
        emailAddress = json['email_address'] ?? null,
        houseAddress = json['house_address'] ?? null;

  @override
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'bvn': bvn,
      'nin': nin,
      'profile_photo': profilePhoto,
      'house_address': houseAddress,
      'email_address': emailAddress
    };
  }
}