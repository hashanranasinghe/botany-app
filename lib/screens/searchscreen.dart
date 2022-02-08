import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  var _toggleIndex = 0;
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: Column(
        children: [
          TopScreenWidget(
              scaffoldKey: _scaffoldKey,
              topLeft: const SizedBox(
                height: 50,
                width: 50,
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff707070)),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ToggleSwitch(
                              initialLabelIndex: _toggleIndex,
                              totalSwitches: 2,
                              activeBgColor: [Color(0xFF012766)],
                              fontSize: 20,
                              minHeight: 50,
                              minWidth: (double.infinity),
                              cornerRadius: 30,
                              inactiveBgColor: Colors.white,
                              borderWidth: 1,
                              borderColor: [Color(0xff707070)],
                              labels: ['English', 'Sinhala'],
                              onToggle: (index) {
                                setState(() {
                                  _toggleIndex = index!;
                                });
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 40),
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Type text here',
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.search,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() {
                                _filterMethod(value);
                              });
                            },
                            onSubmitted: (value) {
                              try {
                                final result =
                                    words.wordslist.firstWhere((element) {
                                  if (_toggleIndex == 0) {
                                    return element.engName == value;
                                  }
                                  return element.sinName == value;
                                }

                                        // element.engName == value
                                        );
                                setState(() {
                                  if (_toggleIndex == 0) {
                                    sinhalaWord = result.sinName;
                                  } else {
                                    sinhalaWord = result.engName;
                                  }
                                });
                              } catch (e) {
                                AlertDialog(
                                  title: Text('No maching word'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          // searchController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Ok'))
                                  ],
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
                    height: 50,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff707070),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: sinhalaWord == null
                            ? const Text(
                                'Result',
                                style: TextStyle(
                                    color: Color(0xff707070), fontSize: 20),
                              )
                            : Text(sinhalaWord!,
                                style: const TextStyle(fontSize: 20))),
                  ),
                  _isLoading
                      ? Container(
                          child:
                              Center(child: const CircularProgressIndicator()),
                          height: 250,
                          width: double.infinity,
                        )
                      : Container(
                          height: 250,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          padding: const EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff707070),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ListView.builder(
                                itemCount: _filterdWords.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 1),
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          if (_toggleIndex == 0) {
                                            sinhalaWord =
                                                _filterdWords[index].sinName!;
                                          } else {
                                            sinhalaWord =
                                                _filterdWords[index].engName!;
                                          }
                                        });
                                      },
                                      title: _toggleIndex == 0
                                          ? Text(
                                              '${_filterdWords[index].engName}')
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
              alignment: FractionalOffset.bottomCenter, child: WaveWidget()),
        ],
      ),
    );
  }
}
