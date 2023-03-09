import 'Group.dart';
import 'ListNotePage.dart';
import 'package:flutter/material.dart';
import 'Note.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var noteList = Note().getNoteList();
  int pageIndex = 0;
  Map<String, List<Map<String, List<String>>>> newGroup = {'': []};
  var myList = Note.myList;
  var editGroupNameController;
  var editGroupname;
  var deleteGroupname;
  final pages = [
    ListNotePage(),
  ];

  deleteGroup(keyName) {
    print(keyName);
    for (var i = 0; i < myList.length; i++) {
      print(myList[i]
          .keys
          .toString()
          .substring(1, myList[i].keys.toString().length - 1));
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          keyName) {
        myList.remove(myList[i]);
        Note().setAllNewNoteList(myList);
        setState(() {
          myList = Note.myList;
        });
      }
    }
    print(myList);
  }

  editGroupNameMethods(
    oldkeyName,
    newkeyName,
  ) {
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]
              .keys
              .toString()
              .substring(1, myList[i].keys.toString().length - 1) ==
          oldkeyName) {
        // newMap = myList[i][oldkeyName] as Map<String, List<Map<String, List<String>>>>;
        var value = myList[i][oldkeyName] as List<Map<String, List<String>>>;
        myList[i][newkeyName] = value;
        myList[i].remove(oldkeyName);
        print(myList[i]);
      }
    }
    Note().setAllNewNoteList(myList);
    setState(() {
      myList = Note.myList;
    });
  }

  @override
  void initState() {
    // deleteGroup("homework");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: buildMyNavBar(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              child: DrawerHeader(
                  padding: EdgeInsets.only(left: 0, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'img/lsj-StripeNoteLIfe_logo.png',
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Note Life",
                          style: TextStyle(
                              // fontFamily: 'Roboto',
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.event_note,
                          color: Colors.black,
                        ),
                        title: Text(
                          "โน๊ต",
                          style: TextStyle(
                              // fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "หมวดหมู่",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto'),
              ),
            ),
            Container(
              child: Column(
                children: myList
                    .map((e) => Card(
                          child: ListTile(
                            trailing: IconButton(
                              iconSize: 20,
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  deleteGroupname = e.keys.toString().substring(
                                      1, e.keys.toString().length - 1);
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) => BsModal(
                                    context: context,
                                    dialog: BsModalDialog(
                                      size: BsModalSize.sm,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      child: BsModalContent(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          BsModalContainer(
                                              title: Text(
                                                  'คุนแน่ใจหรือว่าต้องการลบ ${deleteGroupname}'),
                                              closeButton: true),
                                          BsModalContainer(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: Text(
                                                    "ยกเลิก",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    deleteGroup(
                                                        deleteGroupname);
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: Text(
                                                    "ลบ",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            leading: IconButton(
                              iconSize: 15,
                              icon: Icon(
                                Icons.create,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  editGroupNameController =
                                      new TextEditingController(
                                          text:
                                              '${e.keys.toString().substring(1, e.keys.toString().length - 1)}');
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) => BsModal(
                                    context: context,
                                    dialog: BsModalDialog(
                                      size: BsModalSize.sm,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      child: BsModalContent(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          BsModalContainer(
                                              title: Text('แก้ใขชื่อหมวดหมู่'),
                                              closeButton: true),
                                          BsModalContainer(
                                            child: TextFormField(
                                              controller:
                                                  editGroupNameController,
                                              onChanged: (value) {
                                                editGroupname = value;
                                              },
                                              // key: formKey,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                  Radius.circular(15),
                                                )),
                                                // hintText: 'Kittiwat',
                                              ),
                                            ),
                                          ),
                                          BsModalContainer(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: Text(
                                                    "ยกเลิก",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    // Map<String, List<Map<String, List<String>>>> editName = {'${editGroupname}': e.values};
                                                    // print(e.runtimeType);
                                                    editGroupNameMethods(
                                                        e.keys.toString().substring(
                                                            1,
                                                            e.keys
                                                                    .toString()
                                                                    .length -
                                                                1),
                                                        editGroupname);
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: Text(
                                                    "บันทึก",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            title: Text(
                              e.keys
                                  .toString()
                                  .substring(1, e.keys.toString().length - 1),
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 15),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Group(
                                            groupName: e.keys
                                                .toString()
                                                .substring(
                                                    1,
                                                    e.keys.toString().length -
                                                        1),
                                          )));
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
                    'สร้างหมวดหมู่ใหม่',
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
                                    title: Text('สร้างหมวดหมู่ใหม่'),
                                    closeButton: true),
                                BsModalContainer(
                                  child: TextFormField(
                                    // controller: emailController,
                                    onChanged: (value) {
                                      newGroup = {'$value': []};
                                    },
                                    // key: formKey,
                                    decoration: const InputDecoration(
                                      hintText: "กรอกชื่อหมวดหมู่",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      )),
                                      // hintText: 'Kittiwat',
                                    ),
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
                                          setState(() {
                                            Note().setNoteList(newGroup);
                                          });
                                          Navigator.pop(context);
                                          print(Note.myList.toString());
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
                      )),
            ),
          ],
        ),
      ),
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
      body: pages[pageIndex],
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
                  setState(() {
                    pageIndex = 0;
                  });
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
}
