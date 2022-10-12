import 'dart:convert';
import 'package:ecapro/contract.dart' as constants;

import 'package:ecapro/transformation_model.dart';


class TransactionModel{
  final String? transaction;
  final List<TransformationModel>? transformations;


  TransactionModel({
    this.transaction,
    required this.transformations,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    transaction: json[constants.transaction],
    //transformations: json[constants.transformations],
    transformations: json[constants.transformations] = List<TransformationModel>.from(json[constants.transformations].map((x) => TransformationModel.fromJson(x))),
  );

  // TransactionModel.fromJson(Map<String, dynamic> json){
  // transaction: json[constants.transaction];
  // //transformations: json[constants.transformations],
  // transformations: json[constants.transformations] = List<TransformationModel>.from(json[constants.transformations].map((x) => TransformationModel.fromJson(x)));
  // }

  Map<String, dynamic> toJson() => {
    constants.transaction: transaction,
    constants.transformations: transformations,
  };

}