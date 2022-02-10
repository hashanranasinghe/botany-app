import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          TopScreenWidget(
              scaffoldKey: _scaffoldKey,
              topLeft: Padding(
                padding: const EdgeInsets.only(top: 30, right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SearchScreen.routeName);
                    },
                    icon: const Icon(Icons.home)),
              )),
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTopic(),
                _buildSearchBar(),
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.only(left: 25, right: 25),
            padding: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff707070),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ListView.builder(
                  itemCount: _filterdWords.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 1),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Do you really want to delete?"),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
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
                                          child: const Text('Yes'))
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
                alignment: FractionalOffset.bottomCenter, child: WaveWidget()),
          ),
        ],
      ),
    );
  }

  // Widget _buildSearchfield(){
  Widget _buildTopic() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: const [
          Icon(
            Icons.delete_outline_outlined,
            color: Colors.black,
          ),
          Text(
            'Delete',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return CupertinoSearchTextField(
      prefixInsets: const EdgeInsets.only(left: 20),
      itemSize: 25,
      autofocus: true,
      onChanged: (value) {
        Provider.of<Words>(context, listen: false).filterMethod(value);
      },
      style: const TextStyle(
        fontFamily: 'Poppins',
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
    );
  }
}
