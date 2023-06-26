import 'package:flutter/material.dart';
import 'package:lovebird/widgets/appbar.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final String apiKey = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,'Languange'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            languange(
                'https://flagicons.lipis.dev/flags/4x3/id.svg', 'Indonesia'),
            languange(
                'https://flagicons.lipis.dev/flags/4x3/es.svg', 'English'),
            languange(
                'https://flagicons.lipis.dev/flags/4x3/es.svg', 'Espanol'),
            languange(
                'https://flagicons.lipis.dev/flags/4x3/fr.svg', 'Francis'),
            languange('https://flagicons.lipis.dev/flags/4x3/it.svg', 'Italia'),
            languange(
                'https://flagicons.lipis.dev/flags/4x3/de.svg', 'Germany'),
            languange('https://flagicons.lipis.dev/flags/4x3/jp.svg', 'Japan'),
            languange('https://flagicons.lipis.dev/flags/4x3/ru.svg', 'Rusia'),
          ],
        ),
      ),
    );
  }

  ListTile languange(title, image) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(50), child: Image.asset(image)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
