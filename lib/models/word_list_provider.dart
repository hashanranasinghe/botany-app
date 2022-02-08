import 'package:botanyapp/models/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Words extends ChangeNotifier {
  List<Word> _wordslist = [
    // Word(engName: 'Andraecium', sinName: 'පූමාංගය'),
    // Word(engName: 'Calyx', sinName: 'මණිය'),
  ];
  List<Word> get wordslist {
    return [..._wordslist];
  }

  // void addWord(Word word) {
  //   final newWord = Word(
  //       engName: word.engName,
  //       sinName: word.sinName,
  //       id: DateTime.now().toString());
  //   _wordslist.add(newWord);
  //   notifyListeners();
  // }
  Future<void> addWord(Word word) async {
    final url = Uri.parse(
        'https://dictionary-app-de127-default-rtdb.firebaseio.com/Words.json');
    try {
      final value = await http.post(url,
          body: json.encode({
            'engName': word.engName,
            'sinName': word.sinName,
          }));

      final newWord = Word(
        id: json.decode(value.body)['name'] as String,
        engName: word.engName,
        sinName: word.sinName,
      );
      _wordslist.add(newWord);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://dictionary-app-de127-default-rtdb.firebaseio.com/Words.json');

    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData == null) {
        return;
      }
      final List<Word> loadedWords = [];
      extractData.forEach((wordId, wordData) {
        loadedWords.add(Word(
          id: wordId,
          engName: wordData['engName'],
          sinName: wordData['sinName'],
        ));
      });
      _wordslist = loadedWords;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }


}
