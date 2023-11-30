import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../list_item_order_widget.dart';


class OrderHomeScreen extends StatefulWidget {
  const OrderHomeScreen({super.key});

  @override
  State<OrderHomeScreen> createState() => _OrderHomeScreenState();
}

class _OrderHomeScreenState extends State<OrderHomeScreen> {

  String selected = "0";
  bool _isOnline = false;

  List<String> _orderStatus = [
    "New",
    "Ongoing",
    "Completed",
    "Cancelled",
  ];
  final List<String> items = List<String>.generate(10, (i) => '$i');

  bool _isVisible = true;

  void toogleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8, left: 8, right: 8),
                  child: Visibility(
                    child: Column(
                      children: [
                        Visibility(
                            visible: _isVisible,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Orders",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    FlutterSwitch(
                                      width: 100.0,
                                      showOnOff: true,
                                      value: _isOnline,
                                      activeColor: Colors.orangeAccent,
                                      activeText: "Online",
                                      activeTextColor: Colors.white,
                                      activeTextFontWeight: FontWeight.normal,
                                      inactiveText: "Offline",
                                      inactiveTextFontWeight: FontWeight.normal,
                                      inactiveTextColor: Colors.white,
                                      onToggle: (value) {
                                        setState(() {
                                          _isOnline = !_isOnline;
                                        });
                                      },

                                    )

                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: IconButton(
                                        onPressed: () {
                                          toogleVisibility();
                                          print("Search Orders..");
                                        },
                                        icon: Icon(Icons.search,
                                          color: Colors.orangeAccent,),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 0,
                                        width: 20,
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 280.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: null == _orderStatus
                                              ? 0
                                              : _orderStatus.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              child: Container(
                                                margin: EdgeInsets.only(left: 6, right: 6),
                                                padding: EdgeInsets.only(left: 8, right:8),
                                                child: Center(
                                                    child: Text(
                                                      _orderStatus[index],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                decoration: BoxDecoration(
                                                  color: selected == _orderStatus[index]
                                                      ? Colors.red.shade50
                                                      : Colors.white,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: selected == _orderStatus[index]
                                                        ? Colors.orangeAccent
                                                        : Colors.grey,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selected = _orderStatus[index];
                                                });
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            )),
                        Visibility(
                          visible: !_isVisible,
                          child: TextFormField(
                            controller: _searchTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for order',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white54,
                              ),
                              suffixIcon: TextButton(
                                onPressed: () {
                                  toogleVisibility();
                                },
                                child: Text("Cancel",
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  )
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              height: 600,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListItemOrderWidget();
                  }),
              // decoration: BoxDecoration(
              //   color: Colors.white
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
