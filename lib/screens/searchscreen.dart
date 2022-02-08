import 'package:botanyapp/models/word_list_provider.dart';
import 'package:botanyapp/widgets/drawer_widget.dart';
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> isSelected = [true , false];
  var _isInit = true;
  var _isLoading = false;
  String? sinhalaWord;

  List allResult = [];
  List resultList = [];
  List finalResult = [];




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

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(_onSearchChange);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    searchController.removeListener(_onSearchChange);
    searchController.dispose();
    super.dispose();
  }
  _onSearchChange(){
    searchResult();
    print(searchController.text);
  }

  searchResult(){
    List showResult= [];
    final sWord = Provider.of<Words>(context,listen: false).wordslist;
    if(searchController.text!=""){

      for (int i = 0; i < sWord.length; ++i) {
        var item = sWord[i].engName!.toLowerCase();

        if (item.contains(searchController.text.toLowerCase())) {
          showResult.add(item);
        }
      }

    }else{
      showResult = List.from(allResult);
    }
    setState(() {
      resultList = showResult;

  });

  }



  @override
  Widget build(BuildContext context) {

    final words = Provider.of<Words>(context,listen: false);

    setState(() {
      allResult = words.wordslist;
    });

    searchResult();
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
                        left: 15,right: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff707070)),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          //width: double.infinity,
                          // child: ToggleSwitch(
                          //   initialLabelIndex: 0,
                          //   totalSwitches: 2,
                          //   activeBgColor: const [Color(0xFF012766)],
                          //   fontSize: 20,
                          //   minHeight: 50,
                          //   minWidth: (double.infinity - 9.3),
                          //   //cornerRadius: 30,
                          //   inactiveBgColor: Colors.white,
                          //   borderWidth: 1,
                          //   borderColor: const [Color(0xff707070)],
                          //   labels: const ['English', 'Sinhala'],
                          //   onToggle: (index) {},
                          // ),
                          child: ToggleButtons(
                            children: const [
                              Text('English'),
                              Text('Sinhala'),
                            ],
                            fillColor: const Color(0xFF012766),
                            selectedColor: Colors.white,
                            borderColor: const Color(0xff707070),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30) ),
                            borderWidth: 1,
                            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 214,minHeight: 49),
                            isSelected: isSelected,
                            onPressed: (int newIndex){
                              setState(() {
                                for(int index = 0;index < isSelected.length;index++){
                                  if(index == newIndex){
                                    isSelected[index] = true;
                                  }else{
                                    isSelected[index]=false;
                                  }
                                }
                              });

                            },
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins'
                            ),
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
                    const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff707070),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: Text(
                          sinhalaWord == null ? 'Result' : sinhalaWord!,
                          style: const TextStyle(
                              color: Color(0xff707070),
                              fontSize: 20,
                          fontFamily: 'Poppins'),
                        )),
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff707070),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: _isLoading
                        ? Transform.scale(
                      scale: 0.2,
                      child: const CircularProgressIndicator(
                        strokeWidth: 20,
                        color: Color(0xFF012766),
                      ),

                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ListView.builder(
                          itemCount: resultList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 1),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    sinhalaWord =
                                    words.wordslist[index].sinName!;
                                    print(sinhalaWord);
                                  });
                                },
                                title:
                                searchController.text == "" ?
                                Text(
                                    '${allResult[index].engName}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins'
                                ),):
                                Text(
                                  '${resultList[index]}',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins'
                                  ),)
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
    );


  }


}
