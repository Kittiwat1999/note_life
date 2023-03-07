class Note {
  static List<Map<String, List<Map<String, List<String>>>>> myList = [
    {
      'homework': [
        {
          'homewoik1': ['time', 'date', 'loop']
        },
        {
          'homewoik2': ['time', 'date', 'loop']
        }
      ]
    },
    {'project': []}
  ];
  getNoteList() {
    return myList;
  }

  setNoteList(Map<String, List<Map<String, List<String>>>> list) {
    myList.add(list);
  }

  setAllNewNoteList(
      List<Map<String, List<Map<String, List<String>>>>> newNoteList) {
    myList = newNoteList;
  }
}
