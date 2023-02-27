import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Registration Form',
      home: const FormPage(title: 'Simple Registration Form Page'),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _name = '';
  String _address = '';
  // strDt _date = '';
  int _age = -1;
  int _dob = -1;
  String _maritalStatus = 'single';
  int _selectedGender = 0;
  String _phoneNo = '';
  String _password = '';

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Select Your Provience!'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 1'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 2'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 3'),
      value: 3,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 4'),
      value: 4,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 5'),
      value: 5,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 6'),
      value: 6,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Provience 7'),
      value: 7,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Address', hintText: 'Address'),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        setState(() {
          _address = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _age = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
        hintText: 'DOB',
        labelText: 'Enter Date Of Birth',
      ),
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(-1, 1, 1),
          maxTime: DateTime(2030, 12, 31),
          onConfirm: (date) {
            setState(() {
              // Update the value of the form field with the selected date.
              _dob = date.year;
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Date Of Birth!';
        } else {
          return null;
        }
      },
    ));

    validatePhone(String? value) {
      if (value!.isEmpty) {
        return 'Please enter Phone no';
      }

      Pattern pattern = r'^(\+977)?[9][6-8]\d{8}$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Phone No';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Phone No', hintText: 'Phone'),
      validator: validatePhone,
      onSaved: (value) {
        setState(() {
          _phoneNo = value.toString();
        });
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Single'),
          value: 'single',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Married'),
          value: 'married',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        print("Form Submitted!");
      }
    }

    formWidget.add(ElevatedButton(
        child: const Text('Sign Up'), onPressed: onPressedSubmit));

    return formWidget;
  }
}
