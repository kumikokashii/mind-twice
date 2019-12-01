class UIList {
  Map<String, Item> originalData; //Key is id, Value is item

  UIList.defaultConstructor()
      : originalData = {
          '0': Item('0', 'Reading 1 Long title long title what will happen?',
              DateTime.now(), null, null, null, null),
          '1': Item('0', 'Reading 1', DateTime.now(), null, null, DateTime(2020, 1, 2), null),
          '10': Item('0', 'Reading 1', DateTime.now(), null, null, null, null),
        };

  Map<String, Item> getOriginalData() {
    // print("do you see me?");
    // Map fakeData = {};
    // fakeData['0'] =
    //     Item('0', 'Reading 1', DateTime.now(), null, 'Looks good!', 'See you!');
    // fakeData['1'] = Item('1', 'Reading 2', DateTime.now(), null,
    //     'Looks fantastico!', 'Good nite!');

    // return fakeData;
  } //At initialization, and if choose to, later

  //Call this to set HomeScreen's state
  List<Item> getFilteredAndSorted(settings) {
    List<Item> output = [];
    originalData.forEach((_, item) {
      output.add(item);
      output.add(item);
      output.add(item);
      output.add(item);
    });
    return output;
  }

  addItem(Item item) {
    String id = item.id;
    originalData[id] = item;
  }

  editItem(Item item) {
    String id = item.id;
    originalData[id] = item;
  }

  deleteItemById(int itemId) {
    originalData.remove(itemId);
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

  Item.newNoID() : 
    id=null, title=null, date=DateTime.now(), image=null, firstNote=null, date4back=null, secondNote=null;

  copy() {
    Item newItem =
        Item(id, title, date, image, firstNote, date4back, secondNote);
    return newItem;
  }
}
