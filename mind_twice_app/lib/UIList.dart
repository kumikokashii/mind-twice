class UIList {
  Map<String, Item> originalData; //Key is id, Value is item

  UIList.defaultConstructor()
      : originalData = {
          '0': Item('0', 'Reading 1 Long title long title what will happen?',
              DateTime.now(), null, null, null, null),
          '1': Item('0', 'Reading 1', DateTime(2001, 3, 17), null, null,
              DateTime(2020, 1, 2), null),
          '10': Item(
              '0', 'Reading 1', DateTime(2020, 1, 5), null, null, null, null),
        };

  Future<Item> saveItemInDB(item) {}

  //Fetch from db
  Map<String, Item> getOriginalData() {}

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
    if (settings['sortByDate4Back']) {
      //Its possible that the date4back is null. Split and sort separately
      List<Item> nullList = [];
      List<Item> nonNullList = [];
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

      output = []..addAll(nonNullList)..addAll(nullList);
    } else {
      if (settings['sortAscending']) {
        output.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
      } else {
        output.sort((itemA, itemB) => itemB.date.compareTo(itemA.date));
      }
    }

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
