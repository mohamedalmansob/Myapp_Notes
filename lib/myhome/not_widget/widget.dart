import 'package:flutter/material.dart';

import '../../sqflite/sqflte.dart';
import '../note_view/note_home.dart';
import 'notes_colors.dart';
class NoteWidget extends StatefulWidget {
  final bool isEdit;
  final String? titel;
  final String? desc;
  final int? id;

  const NoteWidget({
    super.key,
    this.isEdit = false,
    this.titel,
    this.desc,
    this.id,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  final sqldb sql = sqldb();
  late TextEditingController titleController;
  late TextEditingController noteController;

  Color cardColor = kTitleColor;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.titel ?? "");
    noteController = TextEditingController(text: widget.desc ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kTitleColor,
            title: Text(
              widget.isEdit ? "تعديل ملاحظة" : "إضافة ملاحظة",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  /// كرت الملاحظة
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "العنوان",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "الملاحظة",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: noteController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "ادخل الملاحظة هنا",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// الأزرار
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            if (titleController.text.isEmpty ||
                                noteController.text.isEmpty) {
                              setState(() {
                                cardColor = Colors.red;
                              });
                              return;
                            }

                            String message;
                            if (widget.isEdit) {
                              await sql.updateData(
                                "UPDATE notes SET name='${titleController.text}', `desc`='${noteController.text}' WHERE id=${widget.id}",
                              );
                              message = "تم التعديل بنجاح";
                            } else {
                              await sql.insertData(
                                "INSERT INTO notes (name, `desc`) VALUES ('${titleController.text}', '${noteController.text}')",
                              );
                              message = "تمت الإضافة بنجاح";
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    NoteHome(successMessage: message),
                              ),
                            );
                          },
                          child: Text(
                            widget.isEdit ? "تعديل" : "إضافة",
                            style: const TextStyle(fontSize: 18,color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
