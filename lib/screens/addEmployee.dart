import 'package:example/components/dialog.dart';
import 'package:example/components/loader.dart';
import 'package:example/constants/text.dart';
import 'package:example/screens/homescreen.dart';
import 'package:example/service/employees.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String? email;
  String? name;
  String? phoneNumber;
  String? salary;
  String? hireDate;
  String? designation;
  DateTime? picked;
  bool isSwitched = false;
  TextEditingController _date = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Loader? loader;
  DialogBox? dialogBox;
  EmployeeData? apis;

  @override
  void initState() {
    // TODO: implement initState
    apis = EmployeeData();
    loader = Loader();
    dialogBox = DialogBox();
    super.initState();
  }

  void addEmployee() async {
    loader!.showLoaderDialog(context);
    if (!_formkey.currentState!.validate()) {
      return;
    }

    try {
      var body = {
        "username": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "designation": designation,
        "salary": salary,
        "hireDate": _date.text,
        "isActive": isSwitched ? "true" : "false"
      };
      var res = await apis!.addEmployee(body);
      setState(() {
        _date.text = "";
      });
      print(res);
      if (!mounted) return;
      Navigator.of(context).pop();
      dialogBox!.showSuccessDialog(context);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      dialogBox!.showErrorsDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Employee", style: kHeadingtext),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: _formkey,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => name = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name is required";
                              }
                              // if (!value.contains("[^A-Za-z]")) {
                              //   return 'Enter a valid name';
                              // }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: "Name",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(18, 0, 24, 0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white54)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => email = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white54)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 10,
                      onChanged: (value) => phoneNumber = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phonenumber is required";
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: "PhoneNumber",
                          prefixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(18, 0, 24, 0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                          hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.white54)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => designation = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Designation is required";
                              }
                              // if (!value.contains("[^A-Za-z]")) {
                              //   return 'Enter a valid work title';
                              // }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: "Designation",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(18, 0, 24, 0),
                                  child: Icon(
                                    Icons.work,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white54)),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _date,
                            readOnly: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: "Hire Date",
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      showDate(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.white54,
                                      size: 20,
                                    )),
                                hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.white54)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => salary = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Salary is required";
                        }
                        // if (!value.contains("[^0-9]")) {
                        //   return 'Salary cannot contain characters';
                        // }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: "Salary",
                          prefixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(18, 0, 24, 0),
                            child: Icon(
                              Icons.currency_rupee,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                          hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.white54)),
                    ),
                  ])),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "IsActive",
                    style: kLightText,
                  ),
                  Switch(
                      activeColor: Color(0xff1F6E8C),
                      value: isSwitched,
                      onChanged: (val) {
                        setState(() {
                          isSwitched = val;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  addEmployee();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 51,
                  decoration: const BoxDecoration(
                      color: Color(0xff5C8374),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child:
                      Text("Submit", style: kbuttontext.copyWith(fontSize: 14)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future showDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    if (picked != null) {
      _date.text = DateFormat('yyyy-MM-dd').format(picked!);
    } else {
      return;
    }
  }
}
