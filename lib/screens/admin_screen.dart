import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/collection.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/home_screen.dart';
import 'package:dagnosis_and_prediction/screens/tableresualtadmin.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminScreen extends StatefulWidget {
  Collection? collection;
  AdminScreen({Key? key, this.collection}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late List<Collection> users;
  late List<Registration> usersname;
  @override
  void initState() {
    super.initState();
    getusersCollection();
  }

  getusersCollection() async {
    users = await DBHelper.getcolliction();
    // print('tttttttttttt ${users.first.firstName}');
    return users;
  }

  getusersName() async {
    return usersname = await DBHelper.getuserlist();
  }

  // sampleFunction() {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: Image.asset(
                              "assets/test.png",
                              fit: BoxFit.contain,
                            )),
                      ],
                    ),
                    const SizedBox(height: 55),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        'Administrator Page :',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 50, right: 50),
                      width: 350.00,
                      child: const TextField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.redAccent,
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white60,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(color: Colors.red, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.red, width: 3),
                          ),
                        ),
                      ),
                    ),

                    // seacrhField,
                    const SizedBox(height: 45),
                    Container(
                      // margin: const EdgeInsets.all(1),
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 370,

                        // height: MediaQuery.of(context).size.width * 2,
                        // width: MediaQuery.of(context).size.width * 2,
                        // width: 600,
                        // height: 500,
                        child: FutureBuilder(
                            future: getusersName(),
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    shrinkWrap: false,
                                    // gridDelegate:
                                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                                    //   crossAxisCount: 1,
                                    // ),

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              4),
                                    ),
                                    itemCount: usersname.length,
                                    itemBuilder: ((context, i) {
                                      // don't show admin screen
                                      return usersname[i].email ==
                                              "adeeb@gmail.com"
                                          ? Container()
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 2),
                                                  padding: EdgeInsets.only(
                                                      bottom: 2),
                                                  child: Material(
                                                    elevation: 5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        users[i].glucoserate! >=
                                                                200
                                                            ? Colors.redAccent
                                                            : Colors.green,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                //         TableResualtadmin(
                                                                //   collection:
                                                                //       users[i],
                                                                // ),
                                                                TableResualtadmin(
                                                              userEmail:
                                                                  usersname[i]
                                                                      .email,
                                                              name: usersname[i]
                                                                  .firstName,
                                                              gender:
                                                                  usersname[i]
                                                                      .gender,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        '${usersname[i].nikeName}'
                                                                    .length >
                                                                8
                                                            ? '${usersname[i].nikeName!.substring(0, 8)}...'
                                                            : '${usersname[i].nikeName}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        // overflow: TextOverflow.ellipsis,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                    }),
                                  ),
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ]),
            ))));
  }
}
