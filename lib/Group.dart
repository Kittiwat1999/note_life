import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'HomePage.dart';
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

  List<String> loopList = ['ครั้งเดียว', 'สัปดาห์', 'เดือน', 'ปี'];

  var newUnitName = "Noname";
  var newUnitDate = DateTime.now().toString();
  var newUnitTime = DateTime.now().toString();
  var newUnitLoop = 'ครั้งเดียว';

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
        print(newUnit.runtimeType);
        Note().addWork(newUnit);
        print(Note().getAllWork());
        setState(() {
          myList = Note.myList;
          Note.allWork;
        });
        // print(myList.toString());
      }
    }
  }

  editUniteWork(workName, editUnit) {
    for (var i = 0; i < workList.length; i++) {
      if (workList[i].keys.toString() == workName.toString()) {
        Note().editWork(editUnit, workList[i]);
        workList.remove(workList[i]);
        workList.add(editUnit);

        print(true);
      }
    }
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          widget.groupName) {
        myList[i].remove(myList[i][widget.groupName]);
        Note().setAllNewNoteList(myList);
        setState(() {
          myList = Note.myList;
          Note.allWork;
        });
      }
    }
  }

  deleteUnitData(workName) {
    for (var i = 0; i < workList.length; i++) {
      if (workList[i].keys.toString() == workName.toString()) {
        Note().removeWork(workList[i]);
        workList.remove(workList[i]);
        print(true);
      }
    }
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          widget.groupName) {
        myList[i].remove(myList[i][widget.groupName]);
        // myList[i][widget.groupName]
        Note().setAllNewNoteList(myList);
        setState(() {
          myList = Note.myList;
          Note.allWork;
        });
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {},
        ),
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
      // bottomNavigationBar: buildMyNavBar(),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 500,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                // color: Color(0xFF5E98E8),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('เลือกหมวดหมู่'),
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
                                  value: item.keys.toString().substring(
                                      1, item.keys.toString().length - 1),
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
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 1.0,
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
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          elevation: 8,
                          offset: const Offset(0, 30),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 30,
                          padding: EdgeInsets.only(left: 10, right: 10),
                        ),
                      ),
                    ),
                  ],
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
                              subtitle:
                                  Text(e.values.toString().substring(2, 12)),
                              trailing: Text(e.values.toString().substring(
                                  20, e.values.toString().length - 2)),
                              onTap: () {
                                showEditModal(e);
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              Card(
                color: Colors.blue,
                child: ListTile(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    iconColor: Colors.white,
                    leading: Icon(
                      Icons.add_rounded,
                    ),
                    title: Text(
                      'เพิ่มงานย่อย',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return BsModal(
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
                                            style:
                                                TextStyle(color: Colors.blue)),
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
                                            print(value);
                                            newUnitDate = value
                                                .toString()
                                                .substring(0, 10);
                                            print(newUnitDate);
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
                                            newUnitTime = value
                                                .toString()
                                                .substring(
                                                    11,
                                                    value.toString().length -
                                                        7);
                                            print(newUnitTime);
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          // height: 47,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Colors.grey.shade400,
                                                width: 1.5,
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "ทำงานซ้ำ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: DropdownButton(
                                                  isExpanded: false,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey,
                                                  ),
                                                  items: loopList
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: newUnitLoop,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newUnitLoop =
                                                          value.toString();
                                                      print(newUnitLoop);
                                                    });
                                                  },
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
                                                Map<String, List<String>>
                                                    newUnit = {
                                                  "${newUnitName.toString()}": [
                                                    '${newUnitDate.toString()}',
                                                    '${newUnitTime.toString()}',
                                                    '${newUnitLoop.toString()}'
                                                  ]
                                                };
                                                print(newUnit);

                                                addNewUnitWork(newUnit);
                                                Navigator.pop(context);
                                              });
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
                            );
                          });
                        })),
              )
            ]),
          ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
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
                  Icons.event,
                  size: 30,
                  color: Colors.white,
                )),
            // Bookmark/Save button
          ],
        ),
      ),
    );
  }

  showEditModal(Map<String, List<dynamic>> editValue) {
    var stringEditVale = editValue[editValue.keys
            .toString()
            .substring(1, editValue.keys.toString().length - 1)]
        .toString();
    //convert String to list
    List<String> listValue = stringEditVale
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    // print(listValue);

    //set date to DateTime instant
    String editnameTop = editValue.keys
        .toString()
        .substring(1, editValue.keys.toString().length - 1);
    //set loop value
    var editname = editnameTop;
    var editDate = listValue[0];
    var editTime = listValue[1];
    var editLoop = listValue[2];
    var setDefaultDateValue =
        DateTime.parse('${listValue[0]} ${listValue[1]}:04Z');
    var editnameController = TextEditingController(text: '${editnameTop}');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return BsModal(
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
                        title: Text(editnameTop), closeButton: true),
                    BsModalContainer(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: editnameController,
                          onChanged: (value) {
                            editname = value;
                          },
                          // key: formKey,
                          decoration: const InputDecoration(
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
                          initialValue: setDefaultDateValue,
                          // initialValue: DateTime(
                          //   int.fromEnvironment(editTime.substring(0, 4)),
                          //   int.fromEnvironment(editTime.substring(5, 7)),
                          //   int.fromEnvironment(
                          //       editTime.substring(8, editTime.length)),
                          // ),
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.black45, fontSize: 12),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              // borderSide: const BorderSide(
                              //   width: 0,
                              //   style: BorderStyle.none,
                              // ),
                            ),
                            suffixIcon: Icon(
                              Icons.event_note,
                              size: 15,
                            ),
                            // labelText: editTime,
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (DateTime? e) {
                            return (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null;
                          },
                          onDateSelected: (DateTime value) {
                            editDate = value.toString().substring(0, 10);
                            print(editDate);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DateTimeFormField(
                          initialValue: setDefaultDateValue,
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.black45, fontSize: 12),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
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
                          autovalidateMode: AutovalidateMode.always,
                          validator: (DateTime? e) {
                            return (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null;
                          },
                          onDateSelected: (DateTime value) {
                            editTime = value
                                .toString()
                                .substring(11, value.toString().length - 7);
                            print(editTime);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // height: 47,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "ทำงานซ้ำ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: DropdownButton(
                                  isExpanded: false,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                  items: loopList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                            ),
                                          ))
                                      .toList(),
                                  value: editLoop,
                                  onChanged: (value) {
                                    setState(() {
                                      editLoop = value.toString();
                                      print(editLoop);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                    BsModalContainer(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              deleteUnitData(editValue.keys);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0.0,
                              shadowColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                Text(
                                  "ลบ",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 50,
                        ),
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
                                Map<String, List<String>> editUnit = {
                                  "${editname.toString()}": [
                                    '${editDate.toString()}',
                                    '${editTime.toString()}',
                                    '${editLoop.toString()}'
                                  ]
                                };
                                // print(editUnit);
                                editUniteWork(editValue.keys, editUnit);
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
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
