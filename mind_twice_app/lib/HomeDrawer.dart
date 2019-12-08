import 'package:flutter/material.dart';

//On every change of settings, the state class will update the parent (home screen).

class HomeDrawer extends StatefulWidget {
  Map<String, bool> listSettings;
  Function onListSettingsChanged;

  HomeDrawer(
      {@required this.listSettings, @required this.onListSettingsChanged})
      : super();

  @override
  _HomeDrawerState createState() => _HomeDrawerState(listSettings);
}

class _HomeDrawerState extends State<HomeDrawer> {
  Map<String, bool> listSettings;

  _HomeDrawerState(this.listSettings);
  final _formKey = GlobalKey<FormState>();

  getSwitchListTileWidget(field, label, icon) {
    return (Container(
      child: SwitchListTile(
        title: Text(label),
        value: listSettings[field] == null ? false : listSettings[field],
        onChanged: (newValue) {
          setState(() {
            listSettings[field] = newValue;
          });
          widget.onListSettingsChanged(listSettings);
        },
        secondary: Icon(icon),
      ),
      padding: EdgeInsets.only(bottom: 20),
    ));
  }

  getSaveToCloudWidget() {
    return (FloatingActionButton.extended(
      onPressed: () {
        print('Save to cloud');
      },
      icon: Icon(Icons.cloud_upload),
      label: Text('Save to cloud'),
    ));
  }

  getUserAccountWidget(context) {
    final emailInputController = TextEditingController();
    final passwordInputController = TextEditingController();

    return (Column(
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: () async {
            var email_password = await showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Center(child: Text('Create account')),
                      content: Column(children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: emailInputController,
                                decoration: InputDecoration(labelText: 'Email'),
                                validator: (value) =>
                                    value.isEmpty ? 'Please enter email' : null,
                              ),
                              TextFormField(
                                controller: passwordInputController,
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                validator: (value) => value.isEmpty
                                    ? 'Please enter password'
                                    : null,
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                        ),
                                        child: Text('Cancel',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                    FlatButton(
                                        color: Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                        ),
                                        child: Text('Create',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            Navigator.of(context).pop([
                                              emailInputController.text,
                                              passwordInputController.text
                                            ]);
                                          } else {
                                            print('NOT VALID');
                                          }
                                        }),
                                  ])
                            ],
                          ),
                        ),
                      ]));
                });
            if (email_password == null) {
              return;
            }
            print(email_password[0]);
            print(email_password[1]);
          },
          icon: Icon(Icons.person_add),
          label: Text('Create account'),
        ),
        SizedBox(height: 20),
        FloatingActionButton.extended(
            onPressed: () {
              print('Log in');
            },
            icon: Icon(Icons.account_circle),
            label: Text('Log in'),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = false;

    return (SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(children: [
          SizedBox(height: 50),
          getSwitchListTileWidget('filterOnceOnly',
              'Only show once-minded items', Icons.battery_unknown),
          getSwitchListTileWidget('sortByDate4Back', 'Sort by date to be back',
              Icons.calendar_today),
          getSwitchListTileWidget(
              'sortAscending', 'Sort ascending', Icons.arrow_upward),
          loggedIn ? getSaveToCloudWidget() : getUserAccountWidget(context)
        ])));
  }
}
