import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../searchscreen.dart';

class AddBody extends StatefulWidget {
  AddBody({required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _AddBodyState createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  //final TextEditingController _textController = TextEditingController();
  final _engFocusNode = FocusNode();
  final _sinFocusNode = FocusNode();

  var _editedWord = Word(engName: '', sinName: '', id: null);
  @override
  void dispose() {
    _engFocusNode.dispose();
    _sinFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    bool isValidate = _form.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _form.currentState!.save();
    // setState(() {
    //   _isLoading = true;
    // });
    // if (_editedProduct.id != null) {
    //   await Provider.of<Products>(context, listen: false)
    //       .updateProduct(_editedProduct.id, _editedProduct);
    // } else {
    //   try {
    Provider.of<Words>(context, listen: false).addWord(_editedWord);
    // } catch (error) {
    //   await showDialog<Null>(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //             title: Text('An error occured!'),
    //             content: Text('Something went wrong'),
    //             actions: [
    //               TextButton(
    //                   onPressed: () {
    //                     Navigator.of(ctx).pop();
    //                   },
    //                   child: Text('Okay'))
    //             ],
    //           ));
    // }
    //  }

    // setState(() {
    //   _isLoading = false;
    // });
    Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
  }

  Widget _buildBotNameField() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        //controller: _textController,
        textAlign: TextAlign.center,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_sinFocusNode);
        },
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the botanical name';
          }
          return null;
        },
        onSaved: (value) {
          _editedWord = Word(
              engName: value, sinName: _editedWord.engName, id: _editedWord.id);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "Botanical Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }

  Widget _buildEnglishNameField() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        //controller: _textController,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the sinhala name';
          }
          return null;
        },
        onSaved: (value) {
          _editedWord = Word(
              engName: _editedWord.engName, sinName: value, id: _editedWord.id);
        },
        onFieldSubmitted: (_) {
          _saveForm();
        },
        focusNode: _sinFocusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "sinhala name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        textInputAction: TextInputAction.done,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextButton(
        onPressed: () {
          _saveForm();
        },
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextButton(
        onPressed: () {
          // _textController.clear();
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TopScreenWidget(
            scaffoldKey: widget.scaffoldKey,
            topLeft: Padding(
              padding: const EdgeInsets.only(top: 30, right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SearchScreen.routeName);
                  },
                  icon: const Icon(Icons.home)),
            )),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          _buildBotNameField(),
                          _buildEnglishNameField(),
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Expanded(child: (_buildCancelButton())),
                                Expanded(child: _buildSaveButton()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        const Align(
            alignment: FractionalOffset.bottomCenter, child: WaveWidget()),
      ],
    );
  }
}
