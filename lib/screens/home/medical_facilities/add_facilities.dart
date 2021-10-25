import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddFacility extends StatelessWidget {
  AddFacility(
      {Key? key, this.name, this.contacts, this.location, this.facilityType})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name, contacts, location, facilityType;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _addFacility() {
    final FormState? state = _formKey.currentState;

    if (state!.validate()) {
      state.save();
      final FacilityModel facility = FacilityModel(
        name: name,
        contacts: contacts,
        location: location,
        facilityType: facilityType,
      );
      //print(facility.toMap());
      //firestore.collection('facility_service').doc().set(facility.toMap());
    }
    state.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Add Facility'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Facility Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSaved: (String? value) {
                    name = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please indicate the facility name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Facility Contact',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSaved: (String? value) {
                    contacts = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please input a contact';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Facility Location',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSaved: (String? value) {
                    location = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please indicate the facility location';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Facility Type',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSaved: (String? value) {
                    facilityType = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please indicate the facility';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.orange,
                  onPressed: _addFacility,
                  child: Text('Add Facility'),
                )
              ],
            )),
      ),
    );
  }
}
