class Patient{
  String email;
  String address;
  String blood;
  String dateOfBirth;
  String firstName;
  String lastName;
  String gender;
  String height;
  String id;
  String phoneNumber;
  String profileImage;
  String state;
  String weight;


  Patient(
      this.email,
      this.address,
      this.blood,
      this.dateOfBirth,
      this.firstName,
      this.lastName,
      this.gender,
      this.height,
      this.id,
      this.phoneNumber,
      this.profileImage,
      this.state,
      this.weight);

  Patient.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    email= json["Email"];
    address= json["address"];
    blood= json["blood"];
    dateOfBirth = json["dateOfBirth"];
    firstName= json["f_name"];
    gender= json["gender"];
    height= json["height"];
    id= json["id"];
    lastName= json["l_name"];
    phoneNumber= json["phoneNumber"];
    state= json["state"];
    weight= json["weight"];
  }
}