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
  static List<Map<String, List<String>>> allWork = [
    {
      'homework1': ['2023-03-03', '18:20', 'สัปดาห์']
    },
    {
      'homework2': ['2023-04-16', '19:50', 'ครั้งเดียว']
    }
  ];
  static String groupSelect = "homework";
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

  addWork(value) {
    allWork.add(value);
  }

  getAllWork() {
    return allWork;
  }

  editWork(newWork, oldWork) {
    allWork.remove(oldWork);
    allWork.add(newWork);
  }

  removeWork(oldValue) {
    allWork.remove(oldValue);
  }
}
