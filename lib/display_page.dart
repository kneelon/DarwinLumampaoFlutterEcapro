
import 'dart:convert';
import 'package:ecapro/transaction_model.dart';
import 'package:ecapro/transformation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {

  num validCount = 0;
  num invalidCount = 0;
  int totalItem = 0;

  num displayValid = 0;
  num displayInvalid = 0;
  int displayTotal = 0;


  num result = 0;
  num totalResult = 0;
  List<TransformationModel> transformation = [];

  Future<List<TransactionModel>> readTransaction() async{
    final jsonData = await rootBundle.rootBundle.loadString('assets/input_data.json');
    //final list = json.decode(jsonData) as List<dynamic>;
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => TransactionModel.fromJson(e)).toList();

  }

  @override
  void initState(){
    super.initState();

  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Display Transactions'),
          centerTitle: true,
        ),

        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: readTransaction(),
                builder: (context, data){
                  if(data.hasError){
                    return Center(child: Text('${data.error}'),);
                  }else if(data.hasData){
                    var items = data.data as List<TransactionModel>;
                    totalItem = items.length;
                    initializeCounter();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          transformation = items[index].transformations!;
                          //print(transformation![0].size.toString());
                          //num size = 0;
                          //totalItem = items.length;

                          //print(transformation.length.toString());
                          for(int i=0; i < transformation.length; i++){
                            num size = transformation[i].size;
                            num qty = transformation[i].qty;
                            result = size * qty;

                            if(result >= 3 && result <= 12){
                              validCount = result + validCount;
                            }

                            validCount = result + validCount;
                            //initializeCounter();
                            //print();
                          }

                          //return result < 3 ? Text(result.toString()) : Container();
                          //return validCount >= 0 ? Text(validCount.toString()) : Container();
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3.0,
                                  horizontal: 12,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Transaction', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(items[index].transaction.toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Valid', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(result >= 3 && result <= 12 ? 'Yes' : 'No'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Balance',style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(result >= 3 && result <= 12 ? '$result' : '0'),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        result >=3 && result <= 12
                                          ? Container() :
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text('Error Reason', style: TextStyle(fontWeight: FontWeight.bold),),
                                                  result < 3 ? const Text('This item is shorter than 3 meters') : Container(),
                                                  result > 12 ? const Text('This item is larger than 12 meters') : Container(),
                                                ],
                                              ),
                                              const Icon(Icons.error_outline, color: Colors.red,),
                                            ],
                                          ),
                                      ],
                                ),
                                  )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Divider(thickness: 1),
                              ),
                            ],
                          );
                        }
                      ),
                    );

                  }else {
                    initializeCounter();
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              initializeCounter(),
              // ElevatedButton(onPressed: (){
              //   initializeCounter();
              // }, child: const Text('Show Valid Item count'))
            ],
          ),
        ),
      ));
  }
  Widget initializeCounter(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Valid :  $validCount',
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),),
          Text(
              'Invalid :  $totalItem - $validCount',
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          Text(
              'Transactions :  $totalItem',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
