import 'package:flutter/material.dart';
import 'package:konwene_app/multiform/user.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// For changing the language
import 'package:flutter_localizations/flutter_localizations.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);

  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  RangeValues _values = RangeValues(0.3, 0.7);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Lets Plan'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.fullName,
                  onSaved: (val) => widget.user.fullName = val,
                  validator: (val) =>
                      val.length > 3 ? null : 'Full name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter your full name',
                    icon: Icon(Icons.restaurant),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: DateTimeField(
                    format: DateFormat("EEE, MMM d, ''yy"),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      hintText: 'Select Date',
                      icon: Icon(Icons.date_range),
                      isDense: true,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: DateTimeField(
                    format: DateFormat("h:mm a"),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Time',
                      hintText: 'Select Time',
                      icon: Icon(Icons.watch),
                      isDense: true,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: RangeSlider(
                    values: _values,
                    min: 0,
                    max: 100,
                    onChanged: (RangeValues values) {
                      setState(() {
                        if (values.end - values.start >= 20) {
                          _values = values;
                        } else {
                          if (_values.start == values.start) {
                            _values = RangeValues(_values.start, _values.start + 20);
                          } else {
                            _values = RangeValues(_values.end - 20, _values.end);
                          }
                        }
                      });
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
