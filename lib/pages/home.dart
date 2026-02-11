import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/category_model.dart';
import '../models/diet_model.dart';
import '../models/popular_diet.dart';
class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<CategoryModel> categories = [];
List<DietModel> diets = [];
List<PopularDietModel> popularDiets = [];

void _getCategories() {
  categories = CategoryModel.getCategories();
}

void _getDiets(){
  diets = DietModel.getDiets();
}

void _getPopularDiets(){
  popularDiets = PopularDietModel.getPopularDiets();
}

void loadData(){
  _getCategories();
  _getDiets();
  _getPopularDiets();
}


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        children: [
          _searchBox(),
          SizedBox(height: 40),
          _categoriesSection(),
          SizedBox(height: 40),
          _recommendationSection(),
          SizedBox(height: 40),
          _popularDietSection(),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Column _popularDietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Text("Popular Diet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
            SizedBox(height: 15,),
            ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context,index) {
                  return Container(

                    height: 100,
                    decoration: BoxDecoration(
                      color: popularDiets[index].isBoxSelected? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          height: 60,
                          width: 60,
                            popularDiets[index].iconPath),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(popularDiets[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                            )
                          ]
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: SvgPicture.asset('assets/icons/button.svg',
                          height: 30,
                          width: 30,)
                        )
                      ]
                    ),
                  );
            },
                separatorBuilder: (context,index) => SizedBox(height: 25),
                padding: EdgeInsets.only(left: 20, right: 20),
                itemCount: popularDiets.length)
          ],
        );
  }

  Column _recommendationSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Text("Recommendation\nfor Diet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
            SizedBox(height: 15),
            SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context,index){
                    return Container(
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: diets[index].boxColor.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(diets[index].iconPath),
                          Column(
                            children: [
                              Text(diets[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                              ),
                              Text('${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}'),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors:[
                                diets[index].isViewSelected?  Color(0xFF6140F4) : Colors.transparent,
                                diets[index].isViewSelected?  Color(0xFF40BAF4) : Colors.transparent,]),
                              borderRadius: BorderRadius.circular(50),
                              ),
                            child: Center(
                              child: Text('View',
                              style: TextStyle(
                                color: diets[index].isViewSelected? Colors.white : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                              ),
                            )
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index) => SizedBox(width: 25),
                  itemCount: diets.length),
            )
          ]
        );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left:20),
            child: Text("Categories",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ))),
            SizedBox(height: 15),
            Container(
              height: 120,
              child: ListView.separated(
                separatorBuilder: (context,index) => SizedBox(width: 25),
                itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index){
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: categories[index].boxColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                            )],
                          ),
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                          Text(
                            categories[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
            )
          ],
        );
  }

  Container _searchBox() {
    return Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )]
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Filter.svg'),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
            ),
            ),
          ),
        );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
        leading: GestureDetector(onTap: () {},
        child:
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/arrow_left_2.svg',
            height: 20,
            width: 20,
            color: Colors.black,
          ),
        ),
        ),
      actions: [
        GestureDetector(
          onTap: () {},
          child:
        Container(
          margin: const EdgeInsets.all(10),
          width: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/dots.svg',
            height: 5,
            width: 5,
            color: Colors.black,
          ),
          ),
        ),
      ],
    );
  }
}
