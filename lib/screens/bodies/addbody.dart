import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController _botController = TextEditingController();
  final TextEditingController _sinController = TextEditingController();
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
    Fluttertoast.showToast(msg: "Add to the word list",
        toastLength: Toast.LENGTH_LONG);
    Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);


  }

  Widget _buildBotNameField(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: TextFormField(
        controller: _botController,
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
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
          ),
          hintText: "Botanical Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
    );
  }

  Widget _buildEnglishNameField() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: TextFormField(
        controller: _sinController,
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
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
          ),
          hintText: "sinhala name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
        textInputAction: TextInputAction.done,
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: TextButton(
        onPressed: () {
          _saveForm();


        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r))),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: TextButton(
        onPressed: () {
          setState(() {
            _botController.clear();
            _sinController.clear();
          });
        },
        child: Text(
          'Clear',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopScreenWidget(
            scaffoldKey: widget.scaffoldKey,
            topLeft: Padding(
              padding: EdgeInsets.only(top: 30.h, right: 10.w),
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
                    SizedBox(
                      height: 120.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp,
                            ),
                          ),
                          _buildBotNameField(context),
                          _buildEnglishNameField(),
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Expanded(child: (_buildCancelButton())),
                                Expanded(child: _buildSaveButton(context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
        const Align(
            alignment: FractionalOffset.bottomCenter, child: WaveWidget()),
      ],
    );
  }
}
