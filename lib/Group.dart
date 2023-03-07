import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'Note.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:date_field/date_field.dart';

// import 'package:table_calendar/table_calendar.dart';

class Group extends StatefulWidget {
  String? groupName;
  Group({super.key, this.groupName});
  State<Group> createState() => GroupState();
}

class GroupState extends State<Group> {
  var myList = Note.myList;
  var getWorkList;
  List<Map<String, List>> workList = [
    // {
    //   'null value': ['undefined', 'undefined', 'undefined']
    // }
  ];

  List<String> loopList = ['สัปดาห์', 'เดือน', 'ปี'];

  var newUnitName;
  var newUnitDate;
  var newUnitTime;
  var newUnitLoop;

  Map<String, List<String>> newUnit = {
    // 'homewoik1': ['time', 'date', 'loop']
  };

  findSelectedValue() {
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          widget.groupName) {
        getWorkList = myList[i][widget.groupName];
        workList = getWorkList;
      }
    }
  }

  addNewUnitWork(newUnit) {
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          widget.groupName) {
        myList[i][widget.groupName]?.add(newUnit);
        Note().setAllNewNoteList(myList);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    findSelectedValue();
    // addNewUnitWork();
    super.initState();
  }

  @override
  Widget build(context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Note Life",
          style: TextStyle(
              // fontFamily: 'Roboto',
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        )),
      ),
      bottomNavigationBar: buildMyNavBar(),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 500,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: myList
                      .map((item) => DropdownMenuItem<String>(
                            value: item.keys
                                .toString()
                                .substring(1, item.keys.toString().length - 1),
                            child: Text(
                              item.keys.toString().substring(
                                  1, item.keys.toString().length - 1),
                              style: const TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: widget.groupName,
                  onChanged: (value) {
                    setState(() {
                      widget.groupName = value as String;
                      findSelectedValue();
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 30,
                    width: 150,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.0,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 150,
                    width: 150,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    elevation: 8,
                    offset: const Offset(0, 30),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 30,
                    padding: EdgeInsets.only(left: 10, right: 10),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: workList
                      .map((e) => Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.event_note,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                              title: Text(
                                e.keys
                                    .toString()
                                    .substring(1, e.keys.toString().length - 1),
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 15),
                              ),
                              onTap: () {
                                showEditModal(e.keys.toString().substring(
                                    1, e.keys.toString().length - 1));
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              Card(
                child: ListTile(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    iconColor: Colors.blue,
                    leading: Icon(
                      Icons.add_rounded,
                    ),
                    title: Text(
                      'เพิ่มงานย่อย',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => showDialog(
                          context: context,
                          builder: (context) => BsModal(
                            context: context,
                            dialog: BsModalDialog(
                              size: BsModalSize.sm,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              child: BsModalContent(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                children: [
                                  BsModalContainer(
                                      title: Text('+ เพิ่มงานย่อย',
                                          style: TextStyle(color: Colors.blue)),
                                      closeButton: true),
                                  BsModalContainer(
                                      child: Column(
                                    children: [
                                      TextFormField(
                                        // controller: emailController,
                                        onChanged: (value) {
                                          newUnitName = value;
                                        },
                                        // key: formKey,
                                        decoration: const InputDecoration(
                                          hintText: "ชื่องานย่อย",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          )),
                                          // hintText: 'Kittiwat',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DateTimeFormField(
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 12),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            // borderSide: const BorderSide(
                                            //   width: 0,
                                            //   style: BorderStyle.none,
                                            // ),
                                          ),
                                          suffixIcon: Icon(
                                            Icons.event_note,
                                            size: 15,
                                          ),
                                          labelText: 'วันที่ครบกำหนด',
                                        ),
                                        mode: DateTimeFieldPickerMode.date,
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: (DateTime? e) {
                                          return (e?.day ?? 0) == 1
                                              ? 'Please not the first day'
                                              : null;
                                        },
                                        onDateSelected: (DateTime value) {
                                          newUnitDate = value.toString();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DateTimeFormField(
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 12),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            // borderSide: const BorderSide(
                                            //   width: 0,
                                            //   style: BorderStyle.none,
                                            // ),
                                          ),
                                          suffixIcon: Icon(
                                            Icons.access_time,
                                            size: 15,
                                          ),
                                          labelText: 'เวลา',
                                        ),
                                        mode: DateTimeFieldPickerMode.time,
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: (DateTime? e) {
                                          return (e?.day ?? 0) == 1
                                              ? 'Please not the first day'
                                              : null;
                                        },
                                        onDateSelected: (DateTime value) {
                                          newUnitTime = value.toString();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "ทำงานซ้ำ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                hint: const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'ทำงานซ้ำ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: loopList
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              item.toString(),
                                                          child: Text(
                                                            item.toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: loopList.first,
                                                onChanged: (value) {
                                                  setState(() {
                                                    newUnitLoop = value;
                                                  });
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 30,
                                                  width: 150,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14, right: 14),
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: Offset(0, 0),
                                                        blurRadius: 0.0,
                                                        spreadRadius: 0.0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.0,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  elevation: 2,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor: Colors.grey,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  maxHeight: 150,
                                                  width: 150,
                                                  padding: null,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                  elevation: 8,
                                                  offset: const Offset(0, 30),
                                                  scrollbarTheme:
                                                      ScrollbarThemeData(
                                                    radius:
                                                        const Radius.circular(
                                                            40),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all<double>(6),
                                                    thumbVisibility:
                                                        MaterialStateProperty
                                                            .all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 30,
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  BsModalContainer(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Text(
                                            "ยกเลิก",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              addNewUnitWork({
                                                "$newUnitName": [
                                                  '$newUnitDate',
                                                  '$newUnitTime',
                                                  '$newUnitLoop'
                                                ]
                                              });
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Text(
                                            "บันทึก",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
              )
            ]),
          ),
          Container(
            color: Colors.white,
            height: 170,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "ยกเลิก",
                    style: TextStyle(color: Colors.blue),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "บันทึก",
                    style: TextStyle(color: Colors.blue),
                  ))
            ]),
          )
        ],
      ),
    ));
  }

  BottomAppBar buildMyNavBar() {
    return BottomAppBar(
      color: Color(0xFF5E98E8),
      // elevation: 6,

      // BottomAppBar content
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Like button
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 10,
            ),
            // Dislike button
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_box,
                  size: 30,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 10,
            ),
            // Comment button
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.import_export,
                  size: 30,
                  color: Colors.white,
                )),
            // Bookmark/Save button
          ],
        ),
      ),
    );
  }

  showEditModal(String topContent) {
    return showDialog(
      context: context,
      builder: (context) => BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.sm,
          crossAxisAlignment: CrossAxisAlignment.center,
          child: BsModalContent(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            children: [
              BsModalContainer(title: Text(topContent), closeButton: true),
              BsModalContainer(
                child: Column(
                  children: [
                    // TableCalendar(
                    //   firstDay: DateTime.utc(2010, 10, 16),
                    //   lastDay: DateTime.utc(2030, 3, 14),
                    //   focusedDay: DateTime.now(),
                    // )
                  ],
                ),
              ),
              BsModalContainer(
                mainAxisAlignment: MainAxisAlignment.end,
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "ยกเลิก",
                        style: TextStyle(color: Colors.blue),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "บันทึก",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
