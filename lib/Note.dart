class Note {
  static List<Map<String, List<Map<String, List<String>>>>> myList = [
    {
      'homework': [
        {
          'homework1': ['2023-03-03', '18:20', 'สัปดาห์']
        },
        {
          'homework2': ['2023-04-16', '19:50', 'ครั้งเดียว']
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
