class UIList {
  Map<String, Item> originalData; //Key is id, Value is item

  UIList.defaultConstructor()
      : originalData = {
          '0': Item('0', 'Reading 1', 'Today', 'Looks good!', 'See you!'),
          '1': Item('1', 'Reading 12', 'Tomorrow', 'Looks good!', 'See you!'),
          '10': Item('10', 'Reading 15', 'Go!', 'Looks good!', 'See you!'),
        };

  Map<String, Item> getOriginalData() {
    print("do you see me?");
    Map fakeData = {};
    fakeData['0'] = Item('0', 'Reading 1', 'Today', 'Looks good!', 'See you!');
    fakeData['1'] =
        Item('1', 'Reading 2', 'Tomorrow', 'Looks fantastico!', 'Good nite!');

    return fakeData;
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
  String date;
  String firstNote;
  String secondNote;

  Item(this.id, this.title, this.date, this.firstNote, this.secondNote);
}
