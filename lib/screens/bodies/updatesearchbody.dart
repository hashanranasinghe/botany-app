import 'package:botanyapp/models/word.dart';
import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/screens/searchscreen.dart';
import 'package:botanyapp/screens/updatescreen.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateSearchBody extends StatefulWidget {
  UpdateSearchBody({Key? key}) : super(key: key);

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
                    icon: Icon(Icons.home)),
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
          SizedBox(
            height: 70,
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
                        itemCount: _filterdWords.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.only(bottom: 1),
                            child: ListTile(
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        UpdateScreen.routeName,
                                        arguments: words.wordslist[index].id);
                                  },
                                  icon: Icon(
                                    Icons.edit,
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
            Icons.update_outlined,
            color: Colors.black,
          ),
          Text(
            'Update',
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
      onChanged: (value) {
        setState(() {
          _filterMethod(value);
        });
      },
      itemSize: 25,
      autofocus: true,
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
