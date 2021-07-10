class DigitalPrescription {
  String doctorId;
  String doctorFirstName;
  String doctorLastName;
  String doctorEmail;
  String doctorPhoneNumber;
  String doctorMaster;
  String doctorProfileImage;
  String prescriptionClassification;
  String prescriptionRX;
  String prescriptionDate;


  DigitalPrescription.name(
      this.doctorId,
      this.doctorFirstName,
      this.doctorLastName,
      this.doctorEmail,
      this.doctorPhoneNumber,
      this.doctorMaster,
      this.doctorProfileImage,
      this.prescriptionClassification,
      this.prescriptionRX,
      this.prescriptionDate);

  DigitalPrescription.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    doctorFirstName = json['doctorFirstName'];
    doctorLastName = json['doctorLastName'];
    doctorEmail = json["doctorEmail"];
    doctorPhoneNumber = json["doctorPhoneNumber"];
    doctorMaster = json["doctorMaster"];
    doctorProfileImage = json["doctorProfileImage"];
    prescriptionClassification = json["prescriptionClassification"];
    prescriptionRX = json["prescriptionRX"];
    prescriptionDate = json["prescriptionDate"];

  }
}
