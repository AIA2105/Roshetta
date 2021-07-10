
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/Prescription/LocalPrescriptionDetails.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import '../PatientHomeScreen.dart';
import 'AddLocalPrescription.dart';
import 'PrescriptionDatabase.dart';
import 'LocalPrescription.dart';

class LocalPrescriptions extends StatefulWidget {
  const LocalPrescriptions({Key key}) : super(key: key);
  @override
  _LocalPrescriptionsState createState() => _LocalPrescriptionsState();
}

class _LocalPrescriptionsState extends State<LocalPrescriptions> {
  bool searchFlag=false;
  bool filterFlag= false;
  List<LocalPrescription> prescriptionList = [];
  TextEditingController _doctorName = new TextEditingController();
  String currentMaster;
  List _masters = [
    'كل التخصصات',
    'جراحة العظام',
    'جراحة عامة',
    'أمراض قلب',
    'جراحة تجميلية',
    'أطفال',
    'باطنة',
    'أسنان',
    'نفسية',
    'عيون',
    'انف وأذن',
    'علاج طبيعي',
    'مسالك بولية',
    'نسا وتوليد',
    'جلدية',
    'ذكورة وعقم',
    'غير ذلك'];

  Future<String> downloadData() async {
    prescriptionList = await PrescriptionDatabase()
        .getLocal(FirebaseAuth.instance.currentUser.uid);
    return Future.value("Data download successfully");
    // return your response
  }

  Future<String> search(String name, String patientId) async {
        prescriptionList = await PrescriptionDatabase().searchLocal(name,patientId);
        print(prescriptionList.length);
        return Future.value("Data download successfully");
  }

  Future<String> filter(String filter, String patientId) async {
      prescriptionList = await PrescriptionDatabase().filterLocal(filter, patientId);
      print(prescriptionList.length);
      return Future.value("Data download successfully");
  }

  @override
  void initState() {
    downloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: searchFlag?search(_doctorName.text, FirebaseAuth.instance.currentUser.uid):filterFlag?filter(currentMaster, FirebaseAuth.instance.currentUser.uid):downloadData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Pallet().background_R,
            body: Center(
                child: CircularProgressIndicator(
              color: Pallet().blue_R,
            )),
          );
        } else {
          if (snapshot.hasError)
            return Scaffold(
              backgroundColor: Pallet().background_R,
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          else {
            return Scaffold(
              backgroundColor: Pallet().background_R,
              appBar: AppBar(
                  actions: [
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              titlePadding: EdgeInsets.only(right: 30,left: 30,top: 10),
                              actionsPadding: EdgeInsets.only(right: 30,left: 30,top: 10),
                              title: InputField_R(
                                  textAlign: TextAlign.right,
                                  title: Widgets().arabicText(
                                      text: 'اسم الطبيب',
                                      fontSize: Spaces().mediumSize,
                                      color: Pallet().blue_R),
                                  icon: Widgets()
                                      .inputFieldPrefix(Icons.person),
                                  textEditingController: _doctorName,
                                  textInputType: TextInputType.streetAddress,
                                  secure: false),
                              actions: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0)),
                                  color: Pallet().blue_R,
                                  child: Widgets().arabicText(
                                    text: 'الكل',
                                    fontSize: 20,
                                    color: Pallet().white_R,
                                  ),
                                  onPressed:  (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LocalPrescriptions()),
                                    );
                                  },
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0)),
                                  color: Pallet().red_R,
                                  child: Widgets().arabicText(
                                    text: 'بحث',
                                    fontSize: 20,
                                    color: Pallet().white_R,
                                  ),
                                  onPressed:  (){
                                      setState((){
                                        searchFlag=true;
                                        filterFlag=false;
                                        Navigator.pop(context);
                                      });
                                  },
                                ),
                              ],
                            );
                          },
                        );

                      },
                        child: Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),
                      child: Icon(
                        Icons.search,
                        color: Pallet().blue_R,
                        size: 30,
                      ),
                    )),
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView.builder(
                                itemCount:_masters.length ,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.8,vertical: 60),
                                    child: GestureDetector(
                                      onTap: (){Navigator.pop(context);},
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Wrap(
                                          children: [
                                            InkWell(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0)),
                                                child: Widgets().arabicText(
                                                    text: '  ${_masters[index]}  ',
                                                    fontSize: Spaces().mediumSize,
                                                    color: Pallet().blue_R),
                                              ),
                                              onTap: (){
                                                if(_masters[index]=='كل التخصصات'){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => LocalPrescriptions()),
                                                  );
                                                }
                                                else{
                                                  setState(() {
                                                    currentMaster=_masters[index];
                                                    filterFlag=true;
                                                    searchFlag=false;
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                        );
                      },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10,left: 10),
                          child: Icon(
                            Icons.filter_list_rounded,
                            color: Pallet().blue_R,
                            size: 30,
                          ),
                        )
                    )

                  ],
                  leading: IconButton(
                      icon: Widgets().backArrowIcon(Pallet().blue_R),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>PatientHomeScreen())
                        );
                      }),
                  centerTitle: true,
                  backgroundColor: Pallet().background_R,
                  elevation: 0,
                  title: Widgets().screenTitle('روشتاتي المحفوظة', Pallet().blue_R)
              ),
              body: Padding(
                padding:EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 30),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return prescriptionList.length==0?Container():Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: InkWell(
                                  highlightColor: Pallet().blue_R,
                                  borderRadius: BorderRadius.circular(80.0),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocalPrescriptionDetails(
                                                    prescriptionList[index])));
                                  },
                                  child: Card(
                                    elevation: 0.5,
                                    color: Pallet().background_R,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 55,
                                            backgroundColor: Pallet().blue_R,
                                            child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Pallet().white_R,
                                                child: ClipOval(
                                                    child: Image.network(
                                                  '${Links().localPrescriptionImage}/${FirebaseAuth.instance.currentUser.uid}/${prescriptionList[index].image}',
                                                  height: 200,
                                                  width: 200,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Pallet().blue_R,
                                                      ),
                                                    );
                                                  },
                                                ))),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Widgets().arabicText(
                                                  text: prescriptionList[index]
                                                      .doctorName,
                                                  fontSize: Spaces().mediumSize,
                                                  color: Pallet().blue_R,
                                                ),
                                                Widgets().arabicText(
                                                  text: prescriptionList[index]
                                                      .date,
                                                  fontSize: Spaces().mediumSize,
                                                  color: Pallet().black,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: prescriptionList.length),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      elevation: 10,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddLocalPrescription()),
                        );
                      },
                      backgroundColor: Pallet().blue_R,
                      child: Icon(
                        Icons.add,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          }
        }
      },
    );
  }
}
