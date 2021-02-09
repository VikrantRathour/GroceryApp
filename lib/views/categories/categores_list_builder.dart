import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/all_category_detail/stores_list_for_all_category.dart';

class CategoriesListBuilder extends StatelessWidget {
  final String currentLocation;
  CategoriesListBuilder({this.currentLocation});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: DatabaseService().getCategoriesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StoresListForAllCategory(
                            category: snapshot.data[index].name,
                          ))),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Image(
                        width: 100.0,
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/${snapshot.data[index].image}'),
                      ),
                      title: Text(snapshot.data[index].name),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: snapshot.data.length,
            );
          }
        });
  }
}
