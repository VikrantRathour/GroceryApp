import 'package:flutter/material.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:provider/provider.dart';

class BottomSheetToUpdateProfile extends StatefulWidget {
  @override
  _BottomSheetToUpdateProfileState createState() =>
      _BottomSheetToUpdateProfileState();
}

class _BottomSheetToUpdateProfileState
    extends State<BottomSheetToUpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String address;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Enter New Address',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Please enter address' : null,
                    onChanged: (val) {
                      setState(() => address = val);
                    },
                    decoration: InputDecoration(hintText: 'Address'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        DatabaseService(uid: user.uid)
                            .updateUserAddress(address);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Update Address',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
