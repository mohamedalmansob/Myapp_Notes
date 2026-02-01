import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mynotes/sqflite/sqflte.dart';
import '../not_widget/notes_colors.dart';
import '../not_widget/widget.dart';
import 'my_not.dart';

class NoteHome extends StatefulWidget {
  final String? successMessage;
  const NoteHome({super.key,this.successMessage});

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {

  List<Map> notes = [];
  sqldb sql = sqldb();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    readData();
    if (widget.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.successMessage!),
          ),
        );
      });
    }
  }

  Future<void> readData() async {
    var response = await sql.readData("SELECT * FROM 'notes' ");
    setState(() {
      notes = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTitleColor,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                "ملاحظات المهندس عبد الله محمد حمود ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Container(
              color: kBodyColor,
            ),
            Container(
              width: 450,
              height: 45,
              decoration: BoxDecoration(
                color: kTitleColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),


            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ListView.builder(
                                itemCount: notes.length,
                                itemBuilder: (context, index) {
                  return

                       Card(
                         color: kCardColor,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,),
                        child: InkWell(
                          onTap: ()async{

                               readData();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return NoteCard(
                                name: notes[index]["name"],
                                desc: notes[index]["desc"],
                                readData:() {
                                  readData();
                                },
                                onEdit: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return NoteWidget(
                                      isEdit: true,
                                      id: notes[index]["id"],
                                      desc: notes[index]["desc"],
                                      titel: notes[index]["name"],
                                    );
                                  },));

                                },
                              );
                            },));

                          },
                          child: ListTile(
                            title: Text("${notes[index]["name"]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 25),
                              maxLines: 1,                // سطر واحد فقط
                              overflow: TextOverflow.ellipsis,),
                            subtitle: Text("${notes[index]["desc"]}"
                              ,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,),
                              maxLines: 1,                // سطر واحد فقط
                              overflow: TextOverflow.ellipsis,),
                            trailing:   IconButton(
                              icon:  Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("تأكيد الحذف"),
                                      content: const Text("هل تريد حذف هذه الملاحظة؟"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
                                        ),
                                        TextButton(
                                          onPressed: () async {

                                            await sql.deleteData(
                                                "DELETE FROM notes WHERE id = ${notes[index]["id"]}"
                                            );
                                            readData();
                                            Navigator.of(context).pop(); // اغلاق الـ Dialog
                                            // تحديث البيانات
                                          },
                                          child: const Text("موافق", style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                            ),
                          ),
                        ),
                      );


                                },
                              ),
                ),


            Padding(
              padding: const EdgeInsets.only(top: 560, right: 270,bottom: 30,left: 10),
              child: Container(
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteWidget(isEdit: false,),
                      ),
                    );


                    readData();
                  },
                  child:  Center(
                    child: Text(
                      "اضافة",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 640, right: 0,bottom: 0,left: 0),
              child: Container(
                width: 540,
                height: 80,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Center(
                  child: Text(
                    "برمجة وتصميم المهندس ؟ محمد عبده حمود المنصوب",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
