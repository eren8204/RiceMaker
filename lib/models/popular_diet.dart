class PopularDietModel{
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool isBoxSelected;

  PopularDietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.isBoxSelected,
});

  static List<PopularDietModel> getPopularDiets(){
    List<PopularDietModel> popularDiets = [];
    popularDiets.add(PopularDietModel(
      name: 'Blueberry Pancake',
      iconPath: 'assets/icons/blueberry-pancake.svg',
      level: 'Medium',
      duration: '30mins',
      calorie: '230kCal',
      isBoxSelected: true,
    ));
    popularDiets.add(PopularDietModel(
      name: 'Salmon Nigiri',
      iconPath: 'assets/icons/salmon-nigiri.svg',
      level: 'Easy',
      duration: '25mins',
      calorie: '150kCal',
      isBoxSelected: false));

    return popularDiets;
  }

}