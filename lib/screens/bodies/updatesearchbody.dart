import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:string_extensions/string_extensions.dart';

class UpdateSearchBody extends StatefulWidget {
  const UpdateSearchBody({Key? key}) : super(key: key);

  @override
  State<UpdateSearchBody> createState() => _UpdateSearchBodyState();
}

class _UpdateSearchBodyState extends State<UpdateSearchBody> {
  @override
  initState() {
    _words =
        _filterdWords = Provider.of<Words>(context, listen: false).wordslist;
    super.initState();
  }

  List<Word> _words = [];
  List<Word> _filterdWords = [];
  String? sinhalaWord;
  var _toggleIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;
  void _filterMethod(value) {
    setState(() {
      _filterdWords = _words
          .where((word) => _toggleIndex == 0
              ? word.engName!.toLowerCase().contains(value.toLowerCase())
              : word.sinName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TopScreenWidget(
                scaffoldKey: _scaffoldKey,
                topLeft: Padding(
                  padding: EdgeInsets.only(top: 30.h, right: 10.w),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SearchScreen.routeName);
                      },
                      icon: const Icon(Icons.home)),
                )),
            Container(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildTopic(),
                  _buildSearchBar(),
                ],
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Container(
              height: 350.h,
              margin: EdgeInsets.only(left: 25.w, right: 25.w),
              padding: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff707070),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: _isLoading
                  ? Container(
                      child: const CircularProgressIndicator(),
                      width: 50.w,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: ListView.builder(
                          itemCount: _filterdWords.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(bottom: 1.h),
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              UpdateScreen.routeName,
                                              arguments:
                                                  _filterdWords[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    )),
                                title: Text('${_filterdWords[index].engName.capitalize}'),
                              ),
                            );
                          }),
                    ),
            ),
            const Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: WaveWidget()),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSearchfield(){
  Widget _buildTopic() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          const Icon(
            Icons.update_outlined,
            color: Colors.black,
          ),
          Text(
            'Update',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return CupertinoSearchTextField(
      prefixInsets: EdgeInsets.only(left: 20.w),
      onChanged: (value) {
        setState(() {
          _filterMethod(value);
        });
      },
      itemSize: 25.sp,
      autofocus: true,
      style: const TextStyle(
        fontFamily: 'Poppins',
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.black12,
      ),
    );
  }
}
