import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/services/database.dart';

class AddStoreView extends StatefulWidget {
  @override
  _AddStoreViewState createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String location;
  int distanceFromUser;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Store'),
        ),
        body: Column(
          children: [
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Please enter store name' : null,
              onChanged: (val) {
                setState(() => name = val);
              },
              decoration: InputDecoration(hintText: 'Store Name'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Please enter location' : null,
              onChanged: (val) {
                setState(() => location = val);
              },
              decoration: InputDecoration(hintText: 'Location'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (val) => (val.isEmpty ||
                      int.tryParse(val) <= 0 ||
                      int.tryParse(val) == null)
                  ? 'Please enter valid distance'
                  : null,
              onChanged: (val) {
                setState(() => distanceFromUser = int.tryParse(val));
              },
              decoration: InputDecoration(hintText: 'Distance from user'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                DatabaseService().addNewStore(name, location, distanceFromUser);
                Navigator.of(context).pop();
              }
            },
            child: Container(
              child: Center(
                  child: Text(
                'Add Store',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              )),
              height: 60.0,
            ),
          ),
        ),
      ),
    );
  }
}
