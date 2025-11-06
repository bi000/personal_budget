import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/providerData.dart';
import 'package:personal_budget/showDialog.dart';
import 'package:provider/provider.dart'; 
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pd;
class Download extends StatefulWidget{
  const Download({super.key});

  @override
  _myDownload createState()=>_myDownload();
}
class _myDownload extends State<Download>{
  double progressValue=0.0;//setting progress bar value from 0.0 to 1.0
  bool isDownloading=false;//controls whent to show progress bar
  bool isDownloading2=false;
   List<String>Header=['ITEMS','AMOUNT','PAIDTO','PAYDATE'];
      List<String>Header1=['Name','Occupation','Amount','Date'];
   String Title="Expenditure Report";
      String Title1="Income Report";
      String alertContent='Success! Saved in Downloads';


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'Data Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: TITLE(),
      ),
      body: Consumer<dataCalculation>(builder:(context,tableinfo,child){
      Map<String,dynamic> Ftabledata=tableinfo.data1;
            Map<String,dynamic> Ftabledata2=tableinfo.data2;

     List<Map<String,dynamic>>allEntries=Ftabledata.values.map((e)=> Map<String,dynamic>.from(e)).toList();//gives the value after removing document ID convert in Map string
          List<Map<String,dynamic>>allEntries2=Ftabledata2.values.map((e)=> Map<String,dynamic>.from(e)).toList();//gives the value after removing document ID convert in Map string

     print('all entries is:$allEntries');
      print(Ftabledata);
        return SingleChildScrollView(
        child:SizedBox(
          width: MediaQuery.of(context).size.width*1,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                color: Colors.white,
                elevation: 10,
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    
                    child: DataTable(
                      columnSpacing: MediaQuery.of(context).size.width*0.05,
                      columns: [
                        DataColumn(label: Text('Name')),
                         DataColumn(label: Text('Occupation')),
                         DataColumn(label: Text('Amount')),
                         DataColumn(label: Text('Date')),
                         DataColumn(label: Text('Remove')),
                      ],
                      //(0: {MONTHS: Jan, OCCU: Teaching , INCOME: 7000, NAME: Bishal}) this is what asMap do return index  0:
                      rows:allEntries.asMap().entries.map((entry){//as Map is used to get index of all entries
                        int index=entry.key;//getting entry index
                        print(index);
                        Map<String,dynamic>rowData=entry.value;//assinging entry vlaue in rowData
                        String documentId=Ftabledata.keys.elementAt(index);//extracting firebase document id like{-OLP7CFWkIgFPu2SI8hB}
                        print(documentId);
                        print('entry is$entry');
                        return DataRow(cells: [
                          DataCell(Text(rowData['NAME'])),
                          DataCell(Text(rowData['OCCU'])),
                          DataCell(Text(rowData['INCOME'].toString())),
                          DataCell(Text(rowData['MONTHS'])),
                          DataCell(IconButton(onPressed: (){
                          removeData(documentId);//calling removeData function passing document Id
                          },
                           icon:Icon(Icons.delete,color:Colors.red,)))
                        ]);
                      }).toList(),
                    ),
                    ),
                   ),
                    ),
                     SizedBox(
                      width: MediaQuery.of(context).size.width*1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                       tooltip: 'Download Data',
                       backgroundColor: Colors.purple,
                      elevation: 10,
                      heroTag: 'btn1',
                       child:
                       isDownloading2
                       ?CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                       )
                        :Icon(Icons.download, color: Colors.white, size: 30),
              onPressed: () {
      // Call your download function here
    startDownload2(allEntries);
                   },
                  ),
                        ],
                      ),
                    )  
             ],
                ),
              )
              ),
                     Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                color: Colors.white,
                elevation: 10,
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,    
                   child: DataTable(
                      columnSpacing: MediaQuery.of(context).size.width*0.05,
                      columns: [
                        DataColumn(label: Text('Name')),
                         DataColumn(label: Text('Amount')),
                         DataColumn(label: Text('Paid To')),
                         DataColumn(label: Text('Date')),
                         DataColumn(label: Text('Remove')),
                      ],
                      //(0: {MONTHS: Jan, OCCU: Teaching , INCOME: 7000, NAME: Bishal}) this is what asMap do return index  0:
                      rows:allEntries2.asMap().entries.map((entry){//as Map is used to get index of all entries
                        int index=entry.key;//getting entry index
                        print(index);
                        Map<String,dynamic>rowData=entry.value;//assinging entry vlaue in rowData
                        String documentId1=Ftabledata2.keys.elementAt(index);//extracting firebase document id like{-OLP7CFWkIgFPu2SI8hB}
                        print(documentId1);
                        print('entry is$entry');
                        return DataRow(cells: [
                          DataCell(Text(rowData['ITEMS'])),
                          DataCell(Text(rowData['AMOUNT'].toString())),
                          DataCell(Text(rowData['PAIDTO'])),
                          DataCell(Text(rowData['PAYDATE'])),
                          DataCell(IconButton(onPressed: (){
                          removeExpenditure(documentId1);
                          },
                           icon:Icon(Icons.delete,color:Colors.red,)))
                        ]);
                      }).toList(),
                    )
                    )
                   )
                    ), 
                    SizedBox(
                      width: MediaQuery.of(context).size.width*1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                       tooltip: 'Download Data',
                       backgroundColor: Colors.purple,
                      elevation: 10,
                      heroTag: 'btn2',
                       child:
                       isDownloading
                       ?CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                       )
                        :Icon(Icons.download, color: Colors.white, size: 30),
              onPressed: () {
      // Call your download function here
    startDownload(allEntries2);
                   },
                  ),
                        ],
                      ),
                    )
             ],
                ),
              )
            ],
          ),
        ),
        
      );
            }),

    );
  }
  void removeData(String docId){
    //listen:false is necessary  to call the provider 
    Provider.of<dataCalculation>(context,listen: false).removeIndexData(docId);//telling or calling provider to remove data from firebase database using docId as Id
    }
    void removeExpenditure(String doc2){
      Provider.of<dataCalculation>(context,listen: false).removeExpenData(doc2);
    }
void startDownload(List<Map<String,dynamic>> allEntries2){
  setState(() {
    isDownloading=true;
    progressValue=0.0;
  });
    generatePDF(allEntries2,Title,Header,(row) => [row['ITEMS']?? 'N/A', row['AMOUNT']?.toString()??'0', row['PAIDTO']??'N/A', row['PAYDATE']??'Unknown'],);
}
void startDownload2(List<Map<String,dynamic>> allEntries){
  setState(() {
    isDownloading2=true;
    progressValue=0.0;
  });
    generatePDF(allEntries,Title1,Header1,(row) => [row['NAME']??'N/A', row['OCCU']?? 'N/A', row['INCOME']?.toString()??'0', row['MONTHS']??'Unknown'],);
}
    Future<void> generatePDF(List<Map<String,dynamic>>entries,String Title,List<String>header,List<String> Function (Map<String,dynamic>)dataExtractor)async{
      final pdf=pd.Document();//creates new PDF document
      pdf.addPage(// Adding new Page to the document
        pd.Page(//Adding page layout here(page document style)
          build: (pd.Context context){//define how page contain is structured(creating structure for data)
            return pd.Column(
              crossAxisAlignment:pd.CrossAxisAlignment.start,
              children: [
                pd.Text('Expenditure Data report',style: pd.TextStyle(fontSize: 20,fontWeight: pd.FontWeight.bold)),
                pd.SizedBox(height: 10),
                pd.TableHelper.fromTextArray(
                  headers:header,
                  data:entries.map((e)=>
                  dataExtractor(e)).toList()
                )
              ]
            );
          }
        )
      );
      try {
        //checking the user permission for the storage
        if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {//access for external storage
      
      Directory? directory;//A reference to a folder in file system

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download'); // Directly access Downloads folder
      } else {
        directory = await getApplicationDocumentsDirectory(); // iOS/Mac fallback
      }

      final filePath = "${directory.path}/$Title.pdf";
      final file = File(filePath);

      //simulating the download by splitting save process into the chunks
      int totalchunk=100;//simulated 100 step for download process
      for(int i=0;i<totalchunk;i++){
        //simulate the chunk delay
        await Future.delayed(Duration(microseconds: 5000));
        setState(() {
          progressValue=i/totalchunk;
        });
      }
      await file.writeAsBytes(await pdf.save());
      setState(() {
        isDownloading=false;
        isDownloading2=false;
      });
      Showdialog.ShowAlert(context,alertContent);
      print(' PDF saved at: $filePath');
    } else {
      print("Permission denied");
    }
  } catch (e) {
    print(" Error: $e");
  }
    }
}