import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/services/database.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  @override
  _AddCategoryBottomSheetState createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Add New Category:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Please enter category name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
                decoration: InputDecoration(hintText: 'Category Name'),
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    DatabaseService().addNewCategory(name);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Add Category',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
