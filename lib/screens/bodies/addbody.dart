
import 'package:botanyapp/widgets/topscreen.dart';
import 'package:botanyapp/widgets/wavewidget.dart';

import 'package:flutter/material.dart';

import '../searchscreen.dart';

class AddBody extends StatefulWidget {
  AddBody({required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _AddBodyState createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  Widget _buildBotNameField(){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "Botanical Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
    );
  }

  Widget _buildEnglishNameField(){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
          hintText: "English Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
    );
  }
  
  Widget _buildSaveButton(){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      child: TextButton(
        onPressed: (){}, child: const Text('Save',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                )
            ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      child: TextButton(
        onPressed: (){
          _textController.clear();
        }, child: const Text('Cancel',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff102248)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                )
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TopScreenWidget(
            scaffoldKey: widget.scaffoldKey,
            topLeft: Padding(
              padding: const EdgeInsets.only(top: 30, right: 10),
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
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          _buildBotNameField(),
                          _buildEnglishNameField(),
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Expanded(child: (_buildCancelButton())),
                                Expanded(child: _buildSaveButton()),
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
            alignment: FractionalOffset.bottomCenter,
            child: WaveWidget()),
      ],


    );
  }
}
