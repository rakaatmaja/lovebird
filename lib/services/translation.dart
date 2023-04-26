import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _baseUrl = 'https://api.mymemory.translated.net';
  
  Future<String> translate(String text, String sourceLang, String targetLang) async {
    final response = await http.get('$_baseUrl/get?q=$text&langpair=$sourceLang|$targetLang' as Uri);
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['responseData']['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
