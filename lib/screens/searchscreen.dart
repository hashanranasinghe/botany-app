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
  String? sinhalaWord;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Words>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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
                        left: 25, right: 25, top: 15, bottom: 15),
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
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              activeBgColor: [Color(0xFF012766)],
                              fontSize: 20,
                              minHeight: 50,
                              minWidth: (double.infinity - 9.3),
                              cornerRadius: 30,
                              inactiveBgColor: Colors.white,
                              borderWidth: 1,
                              borderColor: [Color(0xff707070)],
                              labels: ['English', 'Sinhala'],
                              onToggle: (index) {},
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
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff707070),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: Text(
                      sinhalaWord == null ? 'Result' : sinhalaWord!,
                      style: TextStyle(color: Color(0xff707070), fontSize: 20),
                    )),
                  ),
                  Container(
                    height: 250,
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    padding: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff707070),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: _isLoading
                        ? Container(
                            child: CircularProgressIndicator(),
                            width: 50,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ListView.builder(
                                itemCount: words.wordslist.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 1),
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          sinhalaWord =
                                              words.wordslist[index].sinName!;
                                          print(sinhalaWord);
                                        });
                                      },
                                      title: Text(
                                          '${words.wordslist[index].engName}'),
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
