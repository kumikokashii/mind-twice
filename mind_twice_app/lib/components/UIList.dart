import '../DatabaseHelper.dart';

class UIList {
  Map<String, Item> originalData;

  UIList();

  Future<String> saveItemInDB(Item item) async {
    String id = item.id;
    if (item.id == null) {
      int newId = await DatabaseHelper.instance.insert(item);
      id = newId.toString();
    } else {
      await DatabaseHelper.instance.update(item);
    }
    return id;
  }

  Future<void> deleteItemInDB(Item item) async {
    DatabaseHelper.instance.delete(item);
  }

  Future<void> loadTestData(data) async {
    data.forEach((item) async {
      await saveItemInDB(item);
    });
  }

  //Fetch from db
  Future<void> setOriginalData() async {
    List dbOutput = await DatabaseHelper.instance.getAll();

    Map<String, Item> output = {};
    dbOutput.forEach((row) {
      Item item = Item.fromDBrow(row);
      output[item.id] = item;
    });

    originalData = output;
  }

  //Call this to set HomeScreen's state
  List<Item> getFilteredAndSorted(settings) {
    List<Item> output = [];

    //Filter
    if (settings['filterOnceOnly']) {
      originalData.forEach((_, item) {
        if (item.date4back == null) {
          output.add(item);
        }
      });
    } else {
      originalData.forEach((_, item) {
        output.add(item);
      });
    }

    //Sort
    //Its possible that the date4back is null. Split and sort separately
    List<Item> nullList = [];
    List<Item> nonNullList = [];

    if (settings['sortByDate4Back']) {
      output.forEach((item) {
        if (item.date4back == null) {
          nullList.add(item);
        } else {
          nonNullList.add(item);
        }
      });

      if (settings['sortAscending']) {
        nonNullList
            .sort((itemA, itemB) => itemA.date4back.compareTo(itemB.date4back));
      } else {
        nonNullList
            .sort((itemA, itemB) => itemB.date4back.compareTo(itemA.date4back));
      }
    } else {
      output.forEach((item) {
        if (item.date == null) {
          nullList.add(item);
        } else {
          nonNullList.add(item);
        }
      });

      if (settings['sortAscending']) {
        nonNullList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
      } else {
        nonNullList.sort((itemA, itemB) => itemB.date.compareTo(itemA.date));
      }
    }

    output = []..addAll(nonNullList)..addAll(nullList);
    return output;
  }
}

class Item {
  String id;
  String title;
  DateTime date;
  List<String> images;
  String firstNote;
  DateTime date4back;
  String secondNote;

  Item(this.id, this.title, this.date, this.images, this.firstNote,
      this.date4back, this.secondNote);

  Item.newNoID()
      : id = null,
        title = null,
        date = DateTime.now(),
        images = List(5),
        firstNote = null,
        date4back = null,
        secondNote = null;

  Item.fromDBrow(row)
      : id = row[colId].toString(),
        title = row[colTitle],
        date = row[colDate] == null ? null : DateTime.parse(row[colDate]),
        images = List<String>.from(listColImages.map((col) => row[col])),
        firstNote = row[colFirstNote],
        date4back = row[colDate4back] == null ? null : DateTime.parse(row[colDate4back]),
        secondNote = row[colSecondNote];

  copy() {
    Item newItem =
        Item(id, title, date, images, firstNote, date4back, secondNote);
    return newItem;
  }
}
