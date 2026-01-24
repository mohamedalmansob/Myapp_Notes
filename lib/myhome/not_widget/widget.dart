import 'package:flutter/material.dart';
import '../../sqflite/sqflte.dart';
import 'notes_colors.dart';

class NoteWidget extends StatelessWidget {
  final bool isEdit;
  final String? titel;
  final String? desc;
  final int? id;

  NoteWidget({super.key, this.isEdit = false, this.titel, this.desc, this.id});

  final sqldb sql = sqldb();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: titel ?? "");
    TextEditingController noteController = TextEditingController(text: desc ?? "");

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
              isEdit ? "تعديل ملاحظة" : "إضافة ملاحظة",
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
                    color: kTitleColor,
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
                    if (isEdit) {
                      await sql.updateData(
                          "UPDATE 'notes' SET 'name'='${titleController.text}', 'desc'='${noteController.text}' WHERE id=$id"
                      );
                    } else {
                      await sql.insertData(
                          "INSERT INTO notes (name, `desc`) VALUES ('${titleController.text}', '${noteController.text}')"
                      );
                    }
                    Navigator.pop(context, true);
                  },
                  child: Center(
                    child: Text(
                      isEdit ? "تعديل" : "إضافة",
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
