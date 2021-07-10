class LocalPrescription {
  String patientID;
  String doctorName;
  String master;
  String date;
  String image;


  LocalPrescription(this.patientID, this.doctorName, this.master, this.date, this.image);


  LocalPrescription.fromJson(Map<String, dynamic> json) {
    patientID = json['patient_id'];
    doctorName = json['otherDoctorName'];
    master = json["classification"];
    date = json["date"];
    image = json["filePath"];
  }
}
