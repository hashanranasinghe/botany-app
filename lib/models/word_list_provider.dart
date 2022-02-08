import 'package:botanyapp/models/http_ex.dart';
import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/screens/logincomponents/loginbody.dart';
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

  List<Word> filterdWords = [];

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
    //  https://dictionary-app-de127-default-rtdb.firebaseio.com/

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

  Word findById(String? id) {
    return _wordslist.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String? id, Word newProduct) async {
    final prodIndex = _wordslist.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        'https://dictionary-app-de127-default-rtdb.firebaseio.com/Words/$id.json');
    await http.patch(url,
        body: json.encode({
          'engName': newProduct.engName,
          'sinName': newProduct.sinName,
        }));
    if (prodIndex >= 0) {
      _wordslist[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String? id) async {
    final url = Uri.parse(
        'https://dictionary-app-de127-default-rtdb.firebaseio.com/Words/$id.json');

    final existingProductIndex = _wordslist.indexWhere((prod) => prod.id == id);
    Word? existingProduct = _wordslist[existingProductIndex];
    _wordslist.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _wordslist.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Couldnt delete this');
    }
    existingProduct = null;
  }

  void filterMethod(
    value,
  ) {
    filterdWords = _wordslist
        .where(
            (word) => word.engName!.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}
