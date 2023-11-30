import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListItemOrderWidget extends StatelessWidget {
  const ListItemOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        child: ListTile(
          leading: Container(
              height: 60,
              width: 60,
              child: Center(child: Text("600 X 600",
              style: TextStyle(
                color: Colors.white
              ),)),
            decoration: BoxDecoration(
              color: Colors.orangeAccent
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ORDER # 3267", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),),
          Container(
            height: 30,
            width: 100,
            child: Center(
              child: Text("Takeaway", style: TextStyle(
                color: Colors.grey,
              ),),
            ),
            decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6.0)
            ),
          ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text("My computer is a demage ")),
                  SizedBox(
                    width: 12,
                  ),
                  Text("₹ 600"),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Text("Monday, Feb. 13, 2023 6:56pm", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)
            ],
          ),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const OrderDetailsScreen()));
          },

        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
