import 'package:example/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatefulWidget {
  String name;
  String designation;
  bool isActive;
  DateTime date;
  EmployeeCard(
      {required this.name,
      required this.date,
      required this.designation,
      required this.isActive});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  double difference = 0;
  String formattedDate = '';
  @override
  void initState() {
    // TODO: implement initState
    final date2 = DateTime.now();
    difference = (date2.difference(widget.date).inDays) / 365;

    formattedDate = DateFormat('dd MMMM, yyyy').format(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(difference);
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1713916800&semt=sph',
        ),
        backgroundColor: Colors.transparent,
      ),
      title: Row(
        children: [
          Text(widget.name),
          const SizedBox(
            width: 20,
          ),
          Text(
            formattedDate,
            style: kLightText,
          )
        ],
      ),
      subtitle: Text(widget.designation),
      trailing: Container(
        height: 30,
        width: 65,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: (widget.isActive && difference > 5)
                ? Colors.green
                : widget.isActive
                    ? Colors.blue
                    : Colors.red,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.isActive ? 'isActive' : "Inactive",
          style: kbuttontext,
        ),
      ),
    );
  }
}
