import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:delivery/shared/components/default_radio.dart';
import 'package:delivery/shared/components/primary_button.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String firstname;
  String lastname;
  final List<String> errors = [];
  File imageFile;
  String country;
  final _formKey = GlobalKey<FormState>();
  List<RadioModel> sampleData = [];
  bool hire = true;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  void initState() {
    sampleData.add(new RadioModel(true, 'Hire'));
    sampleData.add(new RadioModel(false, 'Work'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Complete your account",
                  style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor)),
              Text("setup",
                  style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor)),
              SizedBox(
                height: 50,
              ),
              imagePick(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildFirstnameFormField(),
                            SizedBox(
                              height: 30,
                            ),
                            buildLastnameFormField(),
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    cityPicker(),
                    SizedBox(
                      height: 30,
                    ),
                    Text("I want to:",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    hirePicker(),
                    SizedBox(
                      height: 50,
                    ),
                    PrimaryButton(
                      color: kPrimaryColor,
                      title: "CONTINUE",
                      press: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print("Continue");
                          // if all are valid then go to success screen
                          // Navigator.pushNamed(
                          //     context, CompleteProfileScreen.routeName);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Container imagePick() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5), shape: BoxShape.circle),
      child: Stack(
        children: [
          imageFile == null
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.image_not_supported),
                )
              : Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Positioned(
            bottom: 15,
            right: 15,
            child: InkWell(
              onTap: () {
                _getFromGallery();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.camera,
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row hirePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          splashColor: Colors.blueAccent,
          onTap: () {
            setState(() {
              sampleData[1].isSelected = false;
              sampleData[0].isSelected = true;
              hire = true;
            });
          },
          child: new RadioItem(sampleData[0]),
        ),
        InkWell(
          //highlightColor: Colors.red,
          splashColor: Colors.blueAccent,
          onTap: () {
            setState(() {
              sampleData[0].isSelected = false;
              sampleData[1].isSelected = true;
              hire = false;
            });
          },
          child: new RadioItem(sampleData[1]),
        ),
      ],
    );
  }

  Container cityPicker() {
    return Container(
        child: Column(
      children: [
        ///Adding CSC Picker Widget in app
        CSCPicker(
          ///Enable disable state dropdown [OPTIONAL PARAMETER]
          showStates: true,

          /// Enable disable city drop down [OPTIONAL PARAMETER]
          showCities: true,

          ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
          flagState: CountryFlag.ENABLE,

          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
          disabledDropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          ///Default Country
          defaultCountry: DefaultCountry.Morocco,

          ///selected item style [OPTIONAL PARAMETER]
          selectedItemStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
          dropdownHeadingStyle: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

          ///DropdownDialog Item style [OPTIONAL PARAMETER]
          dropdownItemStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          ///Dialog box radius [OPTIONAL PARAMETER]
          dropdownDialogRadius: 10.0,

          ///Search bar radius [OPTIONAL PARAMETER]
          searchBarRadius: 10.0,

          ///triggers once country selected in dropdown
          onCountryChanged: (value) {
            setState(() {
              ///store value in country variable
              countryValue = value;
            });
          },

          ///triggers once state selected in dropdown
          onStateChanged: (value) {
            setState(() {
              ///store value in state variable
              stateValue = value;
            });
          },

          ///triggers once city selected in dropdown
          onCityChanged: (value) {
            setState(() {
              ///store value in city variable
              cityValue = value;
            });
          },
        ),
      ],
    ));
  }

  TextFormField buildFirstnameFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => firstname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFirstNamelNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "FirstName",
        hintText: "Enter your FirstName",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: SizedBox(
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ),
      ),
    );
  }

  TextFormField buildLastnameFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => lastname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNamelNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNamelNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "LastName",
        hintText: "Enter your LastName",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: SizedBox(
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ),
      ),
    );
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    setState(() {});
  }
}
