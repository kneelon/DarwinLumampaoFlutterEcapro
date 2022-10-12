import 'dart:convert';
import 'package:ecapro/contract.dart' as constants;

class TransformationModel{
  final String? partNum;
  final num size;
  final num qty;

  TransformationModel({
    required this.partNum,
    required this.size,
    required this.qty,
  });

  factory TransformationModel.fromJson(Map<String, dynamic> json) => TransformationModel(
    partNum: json[constants.partNum],
    size: json[constants.size],
    qty: json[constants.qty],

  );

  Map<String, dynamic> toJson() => {
    constants.partNum: partNum,
    constants.size: size,
    constants.qty: qty,
  };

}