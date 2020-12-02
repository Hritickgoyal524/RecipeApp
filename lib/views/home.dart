import 'dart:convert';
import 'dart:io';
import 'package:RecipieApp/modal/recipiemodal.dart';
import 'package:RecipieApp/views/recipieview.dart';
import"package:http/http.dart" as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
class Home extends StatefulWidget{
  _HomeState createState()=>_HomeState();
}
class _HomeState extends State<Home>{
  TextEditingController _textEditingController=TextEditingController();
  String applicationid="26abbc0a";
  String applicationkey="1e44beaf00e31f052361de3742b3eefb";
  List<RecipieModal> recipie=new List<RecipieModal>();
 bool _loading=false;

 getRecipie(String query)async{
  
String url="https://api.edamam.com/search?q=${query}&app_id=26abbc0a&app_key=1e44beaf00e31f052361de3742b3eefb";
 var response=await http.get(url);
 print(response.statusCode);
 print(response);
 List<RecipieModal> recipi=new List<RecipieModal>(); 
 Map<String,dynamic>jsondata=jsonDecode(response.body);
 jsondata['hits'].forEach((element){
RecipieModal recipieModal=new RecipieModal(url:element["recipe"]["url"],image: element["recipe"]['image'],label: element["recipe"]['label'],source: element["recipe"]["source"]);
 
  
 recipi.add(recipieModal); });
 setState(() {
   recipie=recipi;
 });
 
 }
  Widget build(BuildContext context){
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  const Color(0xff213A50),
                  const Color(0xff071930)
                ],
                   )),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isIOS? 60: 40 : 30, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "AppGuy",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                         ),
                      ),
                      Text(
                        "Recipes",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700
                           ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "What will you cook today?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(height:5),
                  Text(
                    "Just Enter Ingredients you have and we will show the best recipe for you",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                       ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            decoration: InputDecoration(
                              hintText: "Enter Ingridients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                 ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () {
                              if (_textEditingController.text.isNotEmpty) {
                             setState(() {
                               _loading=true;
                             });
                               getRecipie(_textEditingController.text);
                                setState(() {
                                  _loading=false;
                                });
                                print("doing it");
                              } else {
                                print("not doing it");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                      colors: [
                                    const Color(0xffA2834D),
                                    const Color(0xffBC9A5F)
                                  ],
                                      )),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 18,
                                      color: Colors.white
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  
                 Container(child:
               GridView(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: List.generate(recipie.length, (index) {
                          return GridTile(
                              child: RecipieTile(
                            title: recipie[index].label,
                            imgUrl: recipie[index].image,
                            desc: recipie[index].source,
                            url: recipie[index].url,
                          ));
                        })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  /*_launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              //_launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipieView(
                            postUrl: widget.url,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                             // fontFamily: 'Overpass'),
                        )),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                             // fontFamily: 'OverpassRegular'),
                         ) )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}