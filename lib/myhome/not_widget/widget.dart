import 'package:flutter/material.dart';
import 'package:mynotes/myhome/note_view/note_home.dart';
import '../../sqflite/sqflte.dart';
import 'notes_colors.dart';

class NoteWidget extends StatefulWidget {
  final bool isEdit;
  final String? titel;
  final String? desc;
  final int? id;

  NoteWidget({super.key, this.isEdit = false, this.titel, this.desc, this.id});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  final sqldb sql = sqldb();
  Color isnull=kTitleColor;
  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController(text: widget.titel ?? "");
    TextEditingController noteController = TextEditingController(text: widget.desc ?? "");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTitleColor,
          leading: BackButton(
            color: Colors.white,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 1, left: 10,right: 72),
            child: Text(
              widget.isEdit ? "تعديل ملاحظة" : "إضافة ملاحظة",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(color: kBodyColor),

            Padding(
              padding: const EdgeInsets.only(top: 120, left: 40, right: 40),
              child: Container(
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                    color: isnull,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      "العنوان",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "الملاحظة",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 240,
                      child: TextFormField(
                        controller: noteController,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        maxLines: null,
                        minLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "ادخل الملاحظة هنا",
                          contentPadding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 650, right: 30, left: 280),
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: InkWell(
                  onTap: () async {
                    if (titleController.text.isEmpty || noteController.text.isEmpty) {
                      setState(() {
                        isnull = Colors.red;
                      });
                      return;
                    }
                    String message;
                    if(widget.isEdit && titleController.text.isEmpty && noteController.text.isEmpty)
                    {
                        await sql.updateData(
                            "UPDATE 'notes' SET 'name'='${titleController
                                .text}', 'desc'='${noteController
                                .text}' WHERE id=${widget.id}"
                        );
                        message = "تم التعديل بنجاح ️";


                      }
                      else{
                        await sql.insertData(
                            "INSERT INTO notes (name, `desc`) VALUES ('${titleController
                                .text}', '${noteController.text}')"
                        );
                        message = "تمت الإضافة بنجاح ";
                      }
                     Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NoteHome(
                        successMessage: message,
                      )),);

                  },
                  child: Center(
                    child: Text(
                      widget.isEdit ? "تعديل" : "إضافة",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),

            /// زر الغاء
            Padding(
              padding: const EdgeInsets.only(top: 650, right: 280, left: 40),
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, false); // العودة بدون أي عملية
                  },
                  child: const Center(
                    child: Text(
                      "إلغاء",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
