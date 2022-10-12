import 'package:ecapro/contract.dart' as constants;
import 'dart:convert';
import 'package:ecapro/transaction_model.dart';
import 'package:ecapro/transformation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {

  num validCount = 0;
  num invalidCount = 0;
  int totalItem = 0;

  num result = 0;
  num totalResult = 0;
  List<TransformationModel> transformation = [];

  Future<List<TransactionModel>> readTransaction() async{
    final jsonData = await root_bundle.rootBundle.loadString('assets/input_data.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => TransactionModel.fromJson(e)).toList();

  }


  void check(num i){

    if (i % 0.3 == 0) {
      if(kDebugMode) print('No $i');
    }else {
      if(kDebugMode) print('Yes $i');
    }
  }

  void lateInitialize(){
    Future.delayed(const Duration(seconds: 1), (){
      setState(() {
        initializeCounter();
      });
    });
  }

  @override
  void initState(){
    super.initState();
    lateInitialize();
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


                    return Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          transformation = items[index].transformations!;

                          for(int i=0; i < transformation.length; i++){
                            num size = transformation[i].size;
                            num qty = transformation[i].qty;
                            result = size * qty;

                            if(result >= 3 && result <= 12){
                              validCount = result + validCount;
                            }
                            validCount = result + validCount;
                          }
                          initializeCounter();
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3.0,
                                  horizontal: 12,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              constants.wordTransactionNo,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                                fontSize: 14),),
                                            Text(items[index].transaction.toString(), style: const TextStyle(fontSize: 12),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(constants.capValid, style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(result >= 3 && result <= 12 ? constants.capYes : constants.capNo),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(constants.capBalance,style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(result >= 3 && result <= 12 ? '$result' : constants.zero),
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
                                                  const Text('Error', style: TextStyle(fontWeight: FontWeight.bold),),
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
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              initializeCounter(),
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
            '${constants.capValid} :  $validCount',
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),),
          Text(
              '${constants.capInvalid} :  ${totalItem - validCount}',
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          Text(
              '${constants.capTransactions} :  $totalItem',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
