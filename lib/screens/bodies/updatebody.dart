import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatesearchscreen.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateBody extends StatefulWidget {
  UpdateBody({required this.scaffoldKey, required this.id});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? id;

  @override
  _UpdateBodyState createState() => _UpdateBodyState();
}

class _UpdateBodyState extends State<UpdateBody> {
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editedWord = Word(
    id: null,
    engName: "",
    sinName: "",
  );
  var _initValues = {
    'engName': '',
    'sinName': '',
  };
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (widget.id != null) {
        _editedWord =
            Provider.of<Words>(context, listen: false).findById(widget.id);
        _initValues = {
          'engName': _editedWord.engName!,
          'sinName': _editedWord.sinName!,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    bool isValidate = _form.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedWord.id != null) {
      await Provider.of<Words>(context, listen: false)
          .updateProduct(_editedWord.id, _editedWord);
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(UpdateSearchScreen.routeName);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildBotNameField() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the botanical name';
          }
          return null;
        },
        onSaved: (value) {
          _editedWord = Word(
            id: _editedWord.id,
            engName: value,
            sinName: _editedWord.sinName,
          );
        },
        initialValue: _initValues['engName'],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the sinhala name';
          }
          return null;
        },
        initialValue: _initValues['sinName'],
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
          ),
          hintText: "Sinhala Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
        onSaved: (value) {
          _editedWord = Word(
            id: _editedWord.id,
            engName: _editedWord.engName,
            sinName: value,
          );
        },
        onFieldSubmitted: (_) {
          _saveForm();
        },
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
    );
  }

  Widget _buildUpdateButton() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: TextButton(
        onPressed: () {
          _saveForm();
        },
        child: _isLoading
            ? const CircularProgressIndicator()
            : Text(
                'Update',
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

  Widget _buildCancelButton() {
    return Container(
        padding: EdgeInsets.only(top: 20.h),
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(UpdateSearchScreen.routeName);
          },
          child: Text(
            'Cancel',
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Words>(
      context,
      listen: false,
    ).findById(widget.id);
    return Container(
      child: Column(
        children: [
          TopScreenWidget(
              scaffoldKey: widget.scaffoldKey,
              topLeft: Padding(
                padding: EdgeInsets.only(top: 30.h, right: 10.w),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel)),
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150.h,
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
                              'Update',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                            ),
                            _buildBotNameField(),
                            _buildEnglishNameField(),
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(child: (_buildCancelButton())),
                                  Expanded(child: _buildUpdateButton()),
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
      ),
    );
  }
}
