import './DatabaseHelper.dart';

class UIList {
  Map<String, Item> originalData;

  UIList();

  //Temp while testing
  // UIList.defaultConstructor()
  //     : originalData = {
  //         '0': Item('0', 'Reading 1 Long title long title what will happen?',
  //             DateTime.now(), null, null, null, null),
  //         '1': Item('0', 'Reading 1', DateTime(2001, 3, 17), null, null,
  //             DateTime(2020, 1, 2), null),
  //         '10': Item(
  //             '0', 'Reading 1', DateTime(2020, 1, 5), null, null, null, null),
  //       };

  Future<String> saveItemInDB(item) async {
    String id = item.id;
    if (item.id == null) {
      int newId = await DatabaseHelper.instance.insert(item);
      id = newId.toString();
    } else {
      await DatabaseHelper.instance.update(item);
    }
    return id;
  }

  //Fetch from db
  Future<void> setOriginalData() async {
    List dbOutput = await DatabaseHelper.instance.getAll();

    Map<String, Item> output = {};
    dbOutput.forEach((itemDict) {
      String id = itemDict[colId].toString();
      DateTime date =
          itemDict[colDate] == null ? null : DateTime.parse(itemDict[colDate]);
      DateTime date4back = itemDict[colDate4back] == null
          ? null
          : DateTime.parse(itemDict[colDate4back]);

      Item item = Item(id, itemDict[colTitle], date, itemDict[colImage],
          itemDict[colFirstNote], date4back, itemDict[colSecondNote]);

      output[id] = item;
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
  String image;
  String firstNote;
  DateTime date4back;
  String secondNote;

  Item(this.id, this.title, this.date, this.image, this.firstNote,
      this.date4back, this.secondNote);

  Item.newNoID()
      : id = null,
        title = null,
        date = DateTime.now(),
        image = null,
        firstNote = null,
        date4back = null,
        secondNote = null;

  copy() {
    Item newItem =
        Item(id, title, date, image, firstNote, date4back, secondNote);
    return newItem;
  }
}
