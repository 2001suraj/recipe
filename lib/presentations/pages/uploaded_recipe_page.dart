import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/data/repo/recipe_repo.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';

class UploadedRecipePage extends StatelessWidget {
  static const String routeName = 'uploaded recipe page';

  UploadedRecipePage({
    Key? key,
    required this.email,
    required this.owner,
  }) : super(key: key);
  String email;
  bool owner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: LocalStorage().readdata(),
              builder: (context1, snap) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('all_recipe')
                      .where('owner_email', isEqualTo: email)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          // scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      IndividualPage.routeName,
                                      arguments: IndividualPage(
                                        des: snapshot.data!.docs[index]
                                            ['description'],
                                        name: snapshot.data!.docs[index]
                                            ['owner'],
                                        time: snapshot.data!.docs[index]
                                            ['cook_time'],
                                        image: snapshot.data!.docs[index]
                                            ['photourl'],
                                        ingr: snapshot.data!.docs[index]
                                            ['ingredient'],
                                        step: snapshot.data!.docs[index]
                                            ['steps'],
                                        title: snapshot.data!.docs[index]
                                            ['title'],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 160,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]
                                                ['photourl'],
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        child: Text(
                                          snapshot.data!.docs[index]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                      owner
                                          ? PopupMenuButton<int>(
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.delete),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Delete your recipe")
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              offset: Offset(0, 100),
                                              color: Colors.white,
                                              elevation: 2,
                                              // on selected we show the dialog box
                                              onSelected: (value) {
                                                // if value 1 show dialog
                                                if (value == 1) {
                                                  _showDialog(context,
                                                      title: snapshot.data!
                                                          .docs[index]['title'],
                                                      email:
                                                          snap.data.toString());
                                                  // if value 2 show dialog
                                                }
                                              },
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Text('no data found');
                    }
                  },
                );
              }),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context,
    {required String title, required String email}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Do you want to delete your receipe ? "),
        actions: [
          MaterialButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            child: Text("yes"),
            onPressed: () {
              RecipeRepo().deleteRecipes(title: title, email: email);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
