import 'package:flutter/material.dart';
import 'package:lovebird/widgets/appbar.dart';
import 'package:lovebird/widgets/perawatan.dart';

class PerawatanPage extends StatelessWidget {
  const PerawatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Perawatan'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              perawatanList('Memandikan', 0xFFB5D9E8),
              perawatanList('Potong', 0xFFF5E8AF),
              perawatanList('Penyakit', 0xFFE69E9E),
              const SizedBox(
                height: 8,
              ),
              // perawatanList()
            ],
          ),
        ),
      ),
    );
  }
}
