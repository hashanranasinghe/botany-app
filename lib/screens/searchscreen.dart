import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:string_extensions/string_extensions.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search_screen';
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isInit = true;
  var _isLoading = false;
  List<Word> _words = [];
  List<Word> _filterdWords = [];
  String? sinhalaWord;
  String? typedText;
  var _toggleIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var searchController = TextEditingController();
  List<bool> isSelected = [true, false];
  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  List<FocusNode>? focusToggle;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      var wordlist = Provider.of<Words>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
          _words = _filterdWords =
              Provider.of<Words>(context, listen: false).wordslist;
        });
      });
    }

    searchController.addListener(() {
      setState(() {});
    });

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> shareEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('email', user!.email.toString());
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
  void initState() {
    // TODO: implement initState
    super.initState();
    focusToggle = [focusNodeButton1, focusNodeButton2];
    shareEmail();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNodeButton1.dispose();
    focusNodeButton2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TopScreenWidget(
                    scaffoldKey: _scaffoldKey,
                    topLeft: SizedBox(
                      height: 50.h,
                      width: 50.w,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 120.h,
                          margin: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff707070)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: LayoutBuilder(
                                      builder: (context, con) => ToggleButtons(
                                        constraints: BoxConstraints.expand(
                                            width: con.maxWidth / 2 - 1.7.w),
                                        children: [
                                          Text(
                                            'Botanical',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          Text(
                                            'Sinhala',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18.sp,
                                            ),
                                          )
                                        ],
                                        borderWidth: 1,
                                        borderColor: const Color(0xff707070),
                                        selectedColor: Colors.white,
                                        fillColor: const Color(0Xff012766),
                                        disabledColor: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                        isSelected: isSelected,
                                        onPressed: (index) {
                                          var temp;
                                          setState(() {
                                            for (int indexBtn = 0;
                                                indexBtn < isSelected.length;
                                                indexBtn++) {
                                              if (indexBtn == index) {
                                                isSelected[indexBtn] = true;
                                                setState(() {
                                                  searchController.text = '';
                                                  sinhalaWord = null;
                                                });
                                              } else {
                                                isSelected[indexBtn] = false;
                                                setState(() {
                                                  searchController.text = '';
                                                  sinhalaWord = null;
                                                });
                                              }
                                              _toggleIndex = index;
                                            }
                                          });
                                        },
                                      ),
                                    )
                                    //  ToggleSwitch(
                                    //   initialLabelIndex: _toggleIndex,
                                    //   totalSwitches: 2,
                                    //   activeBgColor: [Color(0xFF012766)],
                                    //   fontSize: 20.sp,
                                    //   minHeight: 50.h,
                                    //   // customTextStyles: [
                                    //   //   TextStyle(
                                    //   //     fontFamily: 'Poppins',
                                    //   //     fontSize: 20,
                                    //   //   ),
                                    //   //   TextStyle(
                                    //   //     fontFamily: 'Poppins',
                                    //   //     fontSize: 20,
                                    //   //   ),
                                    //   // ],
                                    //   activeFgColor: Colors.white,
                                    //   minWidth: (double.infinity),
                                    //   cornerRadius: 30.r,
                                    //   inactiveBgColor: Colors.white,
                                    //   borderWidth: 1.sp,
                                    //   borderColor: [Color(0xff707070)],
                                    //   labels: ['English', 'Sinhala'],
                                    //   onToggle: (index) {
                                    //     setState(() {
                                    //       _toggleIndex = index!;
                                    //     });
                                    //   },
                                    // ),
                                    ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                      hintText: 'Type text here',
                                      border: InputBorder.none,
                                      prefixIcon: Container(
                                        width: 0,
                                      ),
                                      suffixIcon: searchController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                searchController.clear();
                                                setState(() {
                                                  _filterdWords = _words;
                                                  sinhalaWord = null;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Color(0Xff012766),
                                              ))),
                                  textInputAction: TextInputAction.search,
                                  style: TextStyle(fontSize: 20.sp),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      _filterMethod(value);
                                    });
                                  },
                                  onSubmitted: (value) {
                                    try {
                                      setState(() {
                                        final result =
                                            _words.firstWhere((element) {
                                          if (_toggleIndex == 0) {
                                            return element.engName
                                                    ?.toLowerCase()
                                                    .trim() ==
                                                value.toLowerCase().trim();
                                          } else {
                                            return element.sinName?.trim() ==
                                                value.trim();
                                          }
                                        }

                                                // element.engName == value
                                                );

                                        if (_toggleIndex == 0) {
                                          sinhalaWord = result.sinName;
                                          typedText = result.engName;
                                        } else {
                                          sinhalaWord = result.engName;
                                          typedText = result.sinName;
                                        }
                                      });
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              'No maching word found!'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  searchController.clear();
                                                  setState(() {
                                                    sinhalaWord = null;
                                                    _filterdWords = _words;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ok'))
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                              // Container(padding: EdgeInsets.all(20),child: const Text('Type text here', style: TextStyle(
                              //   fontSize: 20

                              // ),
                              // ))
                            ],
                          ),
                        ),
                        Container(
                          height: 50.h,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 15.w, right: 15.w, bottom: 15.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff707070),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                          ),
                          child: Center(
                              child: sinhalaWord == null
                                  ? Text(
                                      'Result',
                                      style: TextStyle(
                                          color: const Color(0xff707070),
                                          fontSize: 20.sp),
                                    )
                                  : Text(sinhalaWord!,
                                      style: TextStyle(fontSize: 20.sp))),
                        ),
                        _isLoading
                            ? Container(
                                child: const Center(
                                    child: CircularProgressIndicator()),
                                height: 230.h,
                                width: double.infinity,
                              )
                            : Container(
                                height: 260.h,
                                margin:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                padding: const EdgeInsets.only(top: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff707070),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.r)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.r),
                                  child: ListView.builder(
                                      itemCount: _filterdWords.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          margin: EdgeInsets.only(bottom: 1.h),
                                          child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                if (_toggleIndex == 0) {
                                                  sinhalaWord =
                                                      _filterdWords[index]
                                                          .sinName!;

                                                  typedText =
                                                      _filterdWords[index]
                                                          .engName!
                                                          .capitalize;
                                                  searchController.text =
                                                      typedText!;
                                                } else {
                                                  sinhalaWord =
                                                      _filterdWords[index]
                                                          .engName!
                                                          .capitalize;
                                                  typedText =
                                                      _filterdWords[index]
                                                          .sinName!;
                                                  searchController.text =
                                                      typedText!;
                                                }
                                              });
                                            },
                                            title: _toggleIndex == 0
                                                ? Text(
                                                    '${_filterdWords[index].engName.capitalize}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18.sp,
                                                    ),
                                                  )
                                                : Text(
                                                    '${_filterdWords[index].sinName}'),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: WaveWidget()),
              ],
            ),
            Positioned(
              bottom: 160.h,
              right: 15.w,
              child: TextButton(
                // style: TextButton.styleFrom(
                //   onSurface: Colors.white,
                //   backgroundColor: Color(0Xff012766),
                // ),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    sinhalaWord = null;
                    _filterdWords = _words;
                  });
                },
                child: Text(
                  'Clear',
                  style: TextStyle(
                      fontSize: 15.sp, color: const Color(0Xff012766)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
