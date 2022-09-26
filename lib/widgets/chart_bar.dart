import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(
      {Key? key, required this.label, required this.spendingAmount, required this.spendingPctOfTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint){
    return Column(
      children: [
        SizedBox(
            height: constraint.maxHeight*0.15,
            child:
            FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
         SizedBox(
          height: constraint.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraint.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
              FractionallySizedBox(
                heightFactor:spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),

        ),
         SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.15,
            child: FittedBox(child: Text(label))),
      ],
    );
  });
  }
}
