import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovebird/models/grid.dart';
import 'package:lovebird/widgets/category.dart';

import '../widgets/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ]; 
  
  final List<PhotoItem> dataGrid = [
    PhotoItem('assets/images/1.jpg'),
    PhotoItem('assets/images/2.jpg'),
    PhotoItem('assets/images/3.jpg'),
    PhotoItem('assets/images/biben.jpg'),
    PhotoItem('assets/images/bubun.jpg'),
    PhotoItem('assets/images/my1.jpg'),
    PhotoItem('assets/images/my2.jpg'),
    PhotoItem('assets/images/my4.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.language))
        ],
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  aspectRatio: 9 / 3,
                  height: 180,
                ),
                items: data.map((e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            e,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Catagory'),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      itemCategory('assets/icons/food.png', 'Makanan', Color(0x007D2B2B)),
                      const SizedBox(width: 16),
                        itemCategory('assets/icons/food.png', 'Jenis', Color(0x007D2B2B)),
                      const SizedBox(width: 16),
                        itemCategory('assets/icons/food.png', 'Perawatan', Color(0x007D2B2B)),
                      const SizedBox(width: 16),
                        itemCategory('assets/icons/food.png', 'Gender', Color(0x007D2B2B)),
                      const SizedBox(width: 16),
                   
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('About'),
              const SizedBox(height: 16),
              about('Apa itu burung Lovebird', 'Lovervbird adalah',
                  const Color(0xffBBDEFA)),
              const SizedBox(height: 10),
              about('Sebelum Memelihara', 'Persiapan sebelum memelihara',
                  const Color(0xffFFCDD2)),
              const SizedBox(height: 10),
              about('Set Up Kandang ', 'Kandang yang baik akan',
                  const Color(0xffFFFAC3)),
              const SizedBox(height: 16),
              const Text('Photo'),
              const SizedBox(height: 16),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataGrid.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, index) {
                  return Card(
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(dataGrid[index].image, fit: BoxFit.cover,),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
