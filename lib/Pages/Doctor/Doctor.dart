class Doctor{
  String id;
  String email;
  String address;
  String firstName;
  String lastName;
  String birthday;
  String master;
  String hospital;
  String gender;
  String phoneNumber;
  String profileImage;


  Doctor(
      this.id,
      this.email,
      this.address,
      this.firstName,
      this.lastName,
      this.birthday,
      this.master,
      this.hospital,
      this.gender,
      this.phoneNumber,
      this.profileImage);

  Doctor.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    email= json["email"];
    address= json["address"];
    birthday = json["birthday"];
    firstName= json["firstName"];
    gender= json["gender"];
    id= json["id"];
    lastName= json["lastName"];
    phoneNumber= json["phoneNumber"];
    master= json["master"];
    hospital= json["hospital"];
  }
}