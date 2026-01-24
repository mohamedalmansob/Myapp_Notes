import 'package:flutter/material.dart';
import 'package:mynotes/sqflite/sqflte.dart';

import '../not_widget/notes_colors.dart';
import 'note_home.dart';

class NoteCard extends StatelessWidget {
  final int id;
  final String name;
  final String desc;
  final VoidCallback onEdit;
  final VoidCallback readData;

   NoteCard({
    super.key,
    required this.id,
    required this.name,
    required this.desc,
    required this.onEdit,
    required this.readData,
  });
  sqldb sql=sqldb();

  @override
  Widget build(BuildContext context) {
    return Directionality(
       textDirection: TextDirection.rtl,
      child: Card(
        color: kBodyColor,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:  EdgeInsets.all(12),
          child: Padding(
            padding:  EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: BackButton(),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.only(right: 130.0),
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      icon:  Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                    IconButton(
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
                                        "DELETE FROM notes WHERE id = $id"
                                    );
                                    readData();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return NoteHome() ;
                                    },));
                                  },
                                  child: const Text("موافق", style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );
                      },

                    ),
                  ],
                ),

                const SizedBox(height: 40),


                SelectableText(
                  desc,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
