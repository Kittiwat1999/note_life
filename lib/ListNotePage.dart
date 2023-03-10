import 'package:flutter/material.dart';
import 'package:note_life/Note.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';

class ListNotePage extends StatefulWidget {
  ListNotePage({super.key});
  State<ListNotePage> createState() => ListNotePageState();
}

class ListNotePageState extends State<ListNotePage> {
  var groupName = Note.groupSelect;
  var myList = Note.myList;
  var getWorkList;
  List<Map<String, List>> workList = [
    // {
    //   'null value': ['undefined', 'undefined', 'undefined']
    // }
  ];

  Map<String, bool> buttonList = {};

  setupButton() {
    for (var i = 0; i < myList.length; i++) {
      // iterate through the top-level list
      var topLevelMap = myList[i];
      for (var key in topLevelMap.keys) {
        // iterate through the keys in the top-level map
        var innerList = topLevelMap[key];
        // print(innerList.runtimeType);
        if (innerList != null) {
          // check if innerList is not null
          for (var j = 0; j < innerList.length; j++) {
            // iterate through the inner list
            var innerMap = innerList[j];
            for (var innerKey in innerMap.keys) {
              // iterate through the keys in the inner map
              buttonList[innerKey] =
                  false; // access the key 'homework1', 'homework2', 'project1', or 'project2'
            }
          }
        }
      }
    }
    print(buttonList);
  }

  // editUniteWork(workName, editUnit) {
  //   for (var i = 0; i < workList.length; i++) {
  //     if (workList[i].keys.toString() == workName.toString()) {
  //       Note().editWork(editUnit, workList[i]);
  //       workList.remove(workList[i]);
  //       workList.add(editUnit);

  //       print(true);
  //     }
  //   }
  //   for (var i = 0; i < myList.length; i++) {
  //     if (myList[i]
  //             .keys
  //             .toString()
  //             .substring(1, myList[i].keys.toString().length - 1) ==
  //         widget.groupName) {
  //       myList[i].remove(myList[i][widget.groupName]);
  //       Note().setAllNewNoteList(myList);
  //       setState(() {
  //         myList = Note.myList;
  //         Note.allWork;
  //       });
  //     }
  //   }
  // }

  // deleteUnitData(workName) {
  //   for (var i = 0; i < workList.length; i++) {
  //     if (workList[i].keys.toString() == workName.toString()) {
  //       Note().removeWork(workList[i]);
  //       workList.remove(workList[i]);
  //       print(true);
  //     }
  //   }
  //   for (var i = 0; i < myList.length; i++) {
  //     if (myList[i]
  //             .keys
  //             .toString()
  //             .substring(1, myList[i].keys.toString().length - 1) ==
  //         widget.groupName) {
  //       myList[i].remove(myList[i][widget.groupName]);
  //       // myList[i][widget.groupName]
  //       Note().setAllNewNoteList(myList);
  //       setState(() {
  //         myList = Note.myList;
  //         Note.allWork;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    setupButton();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(context) {
    return checkNoteList();
  }

  Center checkNoteList() {
    return (buttonList.isEmpty)
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img/frame161.png',
                width: 150,
                fit: BoxFit.cover,
                // color: Colors.red,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "ยังไม่มีงาน",
                style: TextStyle(
                    // fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "เพิ่มและติดตามสิ่งที่ต้องทำใน Note Life",
                style: TextStyle(
                    // fontFamily: 'Roboto',
                    fontSize: 12,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              )
            ],
          ))
        : Center(
            child: Container(
              child: ListView(
                  children: Note.myList
                      .map((e) => Container(
                            child: Column(
                              children: e.values
                                  .map((valE) => Container(
                                        child: Column(
                                          children: valE
                                              .map((unitWork) => Card(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.event_note,
                                                        color: Colors
                                                            .blue.shade700,
                                                        size: 20,
                                                      ),
                                                      title: Text(unitWork.keys
                                                          .toString()
                                                          .substring(
                                                              1,
                                                              unitWork.keys
                                                                      .toString()
                                                                      .length -
                                                                  1)),
                                                      subtitle: Text(unitWork
                                                              .values
                                                              .toString()
                                                              .substring(
                                                                  2, 12) +
                                                          " " +
                                                          unitWork.values
                                                              .toString()
                                                              .substring(
                                                                  14, 19) +
                                                          " " +
                                                          unitWork.values
                                                              .toString()
                                                              .substring(
                                                                  20,
                                                                  unitWork.values
                                                                          .toString()
                                                                          .length -
                                                                      2)),
                                                      trailing: Switch(
                                                        // This bool value toggles the switch.
                                                        value: buttonList?[unitWork
                                                            .keys
                                                            .toString()
                                                            .substring(
                                                                1,
                                                                unitWork.keys
                                                                        .toString()
                                                                        .length -
                                                                    1)] as bool,
                                                        activeColor:
                                                            Colors.blue,
                                                        onChanged:
                                                            (bool value) {
                                                          // This is called when the user toggles the switch.
                                                          setState(() {
                                                            buttonList?[unitWork
                                                                .keys
                                                                .toString()
                                                                .substring(
                                                                    1,
                                                                    unitWork.keys
                                                                            .toString()
                                                                            .length -
                                                                        1)] = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ))
                      .toList()),
            ),
          );
  }
}

        // : Center(
        //     child: Container(
        //       child: ListView(
        //         children: Note.allWork
        //             .map((e) => Card(
        //                   child: ListTile(
        //                     leading: Icon(
        //                       Icons.event_note,
        //                       color: Colors.blue.shade700,
        //                       size: 20,
        //                     ),
        //                     title: Text(e.keys
        //                         .toString()
        //                         .substring(1, e.keys.toString().length - 1)),
        //                     subtitle: Text(
        //                         e.values.toString().substring(2, 12) +
        //                             " " +
        //                             e.values.toString().substring(
        //                                 20, e.values.toString().length - 2)),
        //                     onTap: () => showDialog(
        //                       context: context,
        //                       builder: (context) => BsModal(
        //                         context: context,
        //                         dialog: BsModalDialog(
        //                           size: BsModalSize.sm,
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                           child: BsModalContent(
        //                             decoration: BoxDecoration(
        //                               color: Colors.white,
        //                             ),
        //                             children: [
        //                               BsModalContainer(
        //                                   title: Text(
        //                                     '\"${e.keys.toString().substring(1, e.keys.toString().length - 1)}\" ชองคุณเสร็จแล้วหรือไม่',
        //                                     style: TextStyle(
        //                                         fontSize: 14,
        //                                         fontWeight: FontWeight.normal),
        //                                   ),
        //                                   closeButton: true),
        //                               BsModalContainer(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.end,
        //                                 actions: [
        //                                   ElevatedButton(
        //                                       onPressed: () {
        //                                         Navigator.pop(context);
        //                                       },
        //                                       style: ElevatedButton.styleFrom(
        //                                         backgroundColor: Colors.white,
        //                                         elevation: 0.0,
        //                                         shadowColor: Colors.transparent,
        //                                       ),
        //                                       child: Text(
        //                                         "ไม่",
        //                                         style: TextStyle(
        //                                             color: Colors.grey),
        //                                       )),
        //                                   ElevatedButton(
        //                                       onPressed: () {
        //                                         Navigator.pop(context);
        //                                       },
        //                                       style: ElevatedButton.styleFrom(
        //                                         backgroundColor: Colors.white,
        //                                         elevation: 0.0,
        //                                         shadowColor: Colors.transparent,
        //                                       ),
        //                                       child: Text(
        //                                         "เสร็จสิ้น",
        //                                         style: TextStyle(
        //                                             color: Colors.blue),
        //                                       ))
        //                                 ],
        //                               )
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ))
        //             .toList(),
        //       ),
        //     ),
        //   );