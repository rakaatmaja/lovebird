import 'package:flutter/material.dart';

import '../models/grid.dart';

class Jenis extends StatelessWidget {
  Jenis({super.key});

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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading:
            const IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'Jenis',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
            itemCount: dataGrid.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (_, index) {
              return Card(
                elevation: 0,
                child: ClipRRect(
                  child: Stack(
                    children: [
                      Image.asset(
                        dataGrid[index].image,
                        fit: BoxFit.cover,
                      ),
                      // Positioned(
                      //   child: Container(
                      //       width: double.infinity,
                      //       color: Colors.amber,
                      //       child: Text('Tesa')),
                      // ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
