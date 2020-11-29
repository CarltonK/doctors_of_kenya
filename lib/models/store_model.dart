class StoreModel {
  String title;
  String image;
  bool selected;

  StoreModel({this.title, this.image, this.selected = false});
}

StoreModel equipment = StoreModel(
  title: 'Equipment',
  image: 'assets/images/medical.png',
);
StoreModel attire = StoreModel(
  title: 'Attire',
  image: 'assets/images/scrubs.png',
);
StoreModel perishables = StoreModel(
  title: 'Perishables',
  image: 'assets/images/perishables.png',
);

List<StoreModel> storeModels = [equipment, attire, perishables];
