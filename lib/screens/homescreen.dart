import 'dart:convert';

import 'package:example/components/dialog.dart';
import 'package:example/components/employeeList.dart';
import 'package:example/components/loader.dart';

import 'package:example/constants/text.dart';
import 'package:example/model/employee.dart';
import 'package:example/screens/addEmployee.dart';
import 'package:example/service/employees.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  DialogBox? dialogBox;
  EmployeeData? apis;

  bool isSwitched = false;
  List<EmployeeDetails> employeeData = [];

  @override
  void initState() {
    // TODO: implement initState
    apis = EmployeeData();

    dialogBox = DialogBox();
    setState(() {
      isLoading = true;
    });

    getEmployeeList();
    super.initState();
  }

  Future<void> getEmployeeList() async {
    try {
      var data = await apis!.getEmployee();
      setState(() {
        employeeData = data;
        isLoading = false;
      });
      print("Employee Data--> $data");
    } catch (e) {
      if (!mounted) return;

      dialogBox!.showErrorsDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:
            AppBar(title: Text("Employee List", style: kHeadingtext), actions: [
          IconButton(
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.only(right: 30.0),
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              }),
        ]),
        body: !isLoading
            ? RefreshIndicator(
                onRefresh: getEmployeeList,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeData.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        return employeeData.isNotEmpty
                            ? EmployeeCard(
                                name: employeeData[index].name,
                                date: DateTime.parse(
                                    employeeData[index].hireDate),
                                designation: employeeData[index].designation,
                                isActive: employeeData[index].isActive == 'true'
                                    ? true
                                    : false)
                            : Text(
                                "No Employee in the company",
                                style: kLightText,
                              );
                      })),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddEmployee(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
