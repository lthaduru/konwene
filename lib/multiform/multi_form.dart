import 'package:flutter/material.dart';
import 'package:konwene_app/multiform/empty_state.dart';
import 'package:konwene_app/multiform/form.dart';
import 'package:konwene_app/multiform/user.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        title: Text('Plan a gathering'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(

        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'Add Location by tapping add button below',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: users.length,
                itemBuilder: (_, i) => users[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
//    if (users.length > 0) {
//      var allValid = true;
//      users.forEach((form) => allValid = allValid && form.isValid());
//      if (allValid) {
//        var data = users.map((it) => it.user).toList();
//        for(var i =0; i< data.length; i++) {
//        Firestore.instance.collection('baby').document(data[i].fullName).setData({'name': data[i].fullName, 'votes': 0});
//
//        };
//        Navigator.pop(context);
//      }
//    }
  }
}
