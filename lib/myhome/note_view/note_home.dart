import 'package:flutter/material.dart';

import '../not_widget/widget.dart';
class NoteHome extends StatelessWidget {
   NoteHome({super.key});
   List<Map> notes=[];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.blue.shade800 ,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
                child:
            Text("ملاحظاتي",style:
            TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),)),
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
              decoration:  BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )
              ),
              
            ),
            ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {

              return Card(
                child: ListTile(
                  title: Text("${notes[index]}"),
                ),
              );
            },),
            Padding(
              padding: const EdgeInsets.only(top: 730,right: 300),
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
                  child: Center(child: Text("اضافة",style:
                  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                       fontSize: 20
                  ))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
