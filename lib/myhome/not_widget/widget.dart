import 'package:flutter/material.dart';

import '../../sqflite/sqflte.dart';
class NoteWidget extends StatelessWidget {
  NoteWidget({super.key});
  sqldb sql=sqldb();
  @override
  Widget build(BuildContext context) {
    TextEditingController titele=TextEditingController();
    TextEditingController note=TextEditingController();
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.blue.shade800 ,
          title: Padding(
            padding: const EdgeInsets.only(top: 1,left: 100),
            child: Text("اضافة ملاحظة",style:
            TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.grey.shade700,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120,left: 40,right: 40),
              child: Container(
                width: 400,
                height: 500,
                decoration:  BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )
                ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Text("العنوان",style:
                     TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 20
                     )),
                   ),
                   SizedBox(height: 20,),
                   SizedBox(
                     width: 300,
                     child: TextFormField(
                       controller: titele,
                       decoration: InputDecoration(
                         filled: true,
                         enabledBorder: OutlineInputBorder(

                           borderRadius: BorderRadius.circular(20)
                         ),
                         focusedBorder:  OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20)
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 50,),
                   Text("الملاحظة",style:
                   TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                   )),
                   SizedBox(height: 20,),
                   SizedBox(
                     width: 300,
                     height: 240,
                     child: TextFormField(
                       controller: note,
                       textAlignVertical: TextAlignVertical.top,
                       textAlign: TextAlign.start,
                       maxLines: null,
                       minLines: 3,
                       decoration: InputDecoration(
                         filled: true,
                         hintText: "ادخل الملاحظة هنا",
                         contentPadding: EdgeInsets.symmetric(vertical: 60,horizontal: 10),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),


                         ),
                         focusedBorder:  OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),


                         ),
                       ),
                     ),
                   ),
                 ],
               ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 650,right: 30,left: 280),
              child: Container(
                width: 120,
                height: 80,
                decoration:  BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                ),
                child: InkWell(
                  onTap: ()async{
                 await sql.insertData("INSERT INTO 'notes' ('name', 'desc') VALUES ('${titele.text}', '${note.text}')");
                  },
                  child: Center(child: Text("حفظ",style:
                  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 650,right: 280,left: 40),
              child: Container(
                width: 120,
                height: 80,
                decoration:  BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return NoteWidget();
                    },));
                  },
                  child: Center(child: Text("الغاء",style:
                  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
