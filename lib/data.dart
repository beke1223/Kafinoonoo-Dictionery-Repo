import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'data.g.dart';

@riverpod
class Data extends _$Data {
  final List<Map<String, dynamic>> allData = [
    {"name": "Daniel", "country": "Ethiopia"},
    {"name": "Amanuel", "country": "Ethiopia"},
    {"name": "Kumisa", "country": "Ethiopia"},
    {"name": "Aebe", "country": "Bonga"},
    {"name": "Daniel", "country": "Ethiopia"},
    {"name": "Daniel", "country": "Ethiopia"},
    {"name": "Amanuel", "country": "Ethiopia"},
    {"name": "Kumisa", "country": "Bole"},
    {"name": "Aebe", "country": "Ethiopia"},
    {"name": "Daniel", "country": "Borena"}
  ];

  @override
  build() {
    return allData;
  }

  void filterKafinoonoo(String kafinoonooWord) {
    List<Map<String, dynamic>> searchWord = [];
    if (kafinoonooWord.isEmpty) {
      searchWord = allData;
    } else {
      searchWord = (state as List<Map<String, dynamic>>)
          .where((element) => element['name']
              .toString()
              .toLowerCase()
              .contains(kafinoonooWord.toLowerCase()))
          .toList();
    }
    state = searchWord;
  }

  void filterEnglish(String englishWord) {
    List<Map<String, dynamic>> searchWord = [];
    if (englishWord.isEmpty) {
      searchWord = allData;
    } else {
      searchWord = (state as List<Map<String, dynamic>>)
          .where((element) => element['country']
              .toString()
              .toLowerCase()
              .contains(englishWord.toLowerCase()))
          .toList();
    }
    state = searchWord;
  }
}
