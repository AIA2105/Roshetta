class Pharmacy{
  String id;
  String email;
  String address;
  String pharmacyName;
  String firstName;
  String lastName;
  String delivery;
  String workHours;
  String phoneNumber;
  String profileImage;


  Pharmacy(
      this.id,
      this.email,
      this.address,
      this.pharmacyName,
      this.firstName,
      this.lastName,
      this.delivery,
      this.workHours,
      this.phoneNumber,
      this.profileImage);

  Pharmacy.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    email= json["email"];
    address= json["address"];
    pharmacyName= json["pharmacyName"];
    delivery = json["delivery"];
    firstName= json["firstName"];
    workHours= json["workHours"];
    id= json["id"];
    lastName= json["lastName"];
    phoneNumber= json["phoneNumber"];
  }
}