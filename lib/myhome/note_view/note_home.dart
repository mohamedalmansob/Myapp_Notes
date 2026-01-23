import 'package:flutter/material.dart';
import 'package:mynotes/sqflite/sqflte.dart';
import '../not_widget/widget.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({super.key});

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
          backgroundColor: Colors.blue.shade800,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                "ملاحظاتي",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.grey.shade700,
            ),
            Container(
              width: 450,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            // ====== LIST ======
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${notes[index]["name"]}"),
                    subtitle: Text("${notes[index]["desc"]}"),
                  ),
                );
              },
            ),

            // ====== ADD BUTTON ======
            Padding(
              padding: const EdgeInsets.only(top: 730, right: 300),
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteWidget(),
                      ),
                    );

                    // تحديث تلقائي بعد الرجوع
                    readData();
                  },
                  child: const Center(
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
          ],
        ),
      ),
    );
  }
}
