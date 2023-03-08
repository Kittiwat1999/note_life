class Note {
  static List<Map<String, List<Map<String, List<String>>>>> myList = [
    {
      'homework': [
        {
          'homewoik1': ['2023-03-03', 'date', 'loop']
        },
        {
          'homewoik2': ['2023-04-16', 'date', 'loop']
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
