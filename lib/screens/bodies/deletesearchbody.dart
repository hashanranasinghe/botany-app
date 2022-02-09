import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../deletesearchscreen.dart';
import '../searchscreen.dart';

class DeleteSearchBody extends StatefulWidget {
  DeleteSearchBody({Key? key}) : super(key: key);

  @override
  State<DeleteSearchBody> createState() => _DeleteSearchBodyState();
}

class _DeleteSearchBodyState extends State<DeleteSearchBody> {
  List<Word> _words = [];
  List<Word> _filterdWords = [];
  var _isInit = true;
  var _isLoading = false;
  String? sinhalaWord;
  var _toggleIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // @override
  // initState() {

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _words = _filterdWords = Provider.of<Words>(context).wordslist;
      // var wordlist = Provider.of<Words>(context).fetchAndSetProduct().then((_) {
      //   setState(() {
      //     _isLoading = false;

      //   });
      // });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

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
    //final scaffold = Scaffold.of(context);
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
              height: 250,
              margin: EdgeInsets.only(left: 25.w, right: 25.w),
              padding: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff707070),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: ListView.builder(
                    itemCount: _filterdWords.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 1.h),
                        child: ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          'Dou you really wan\'t to delete? '),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No'),
                                        ),
                                        FlatButton(
                                            onPressed: () {
                                              Provider.of<Words>(context,
                                                      listen: false)
                                                  .deleteProduct(
                                                      _filterdWords[index].id);
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      DeleteSearchScreen
                                                          .routeName);
                                            },
                                            child: Text('Yes'))
                                      ],
                                    );
                                  },
                                );
                              },
                              // Navigator.of(context).pushNamed(
                              //     UpdateScreen.routeName,
                              //     arguments: words.wordslist[index].id);

                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                          title: Text('${_filterdWords[index].engName}'),
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
          Icon(
            Icons.delete_outline_outlined,
            color: Colors.black,
          ),
          Text(
            'Delete',
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
      itemSize: 25.sp,
      autofocus: true,
      onChanged: (value) {
        Provider.of<Words>(context, listen: false).filterMethod(value);
      },
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
