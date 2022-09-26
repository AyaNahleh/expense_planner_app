import 'package:expenseplanner/models/transaction.dart';
import 'package:expenseplanner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);
  final List<Transaction> recentTransaction;

  List <Map<String,Object>>get groupedTransactionValues{

    return List.generate(7, (index) {
      final weekDay= DateTime.now().subtract(Duration(days: index));
      double totalSum=0.0;
      for(var i=0; i< recentTransaction.length;i++ ){
        if(recentTransaction[i].date.day==weekDay.day&&
            recentTransaction[i].date.month==weekDay.month&&
           recentTransaction[i].date.year==weekDay.year){
          totalSum+=recentTransaction[i].amount;

        }
      }
      return {'day':DateFormat.E().format(weekDay).substring(0, 1),'amount':totalSum};
    }).reversed.toList();
  }

  double get maxSpending{
    return groupedTransactionValues.fold(0.0,(sum,item){
      return sum + (item['amount']as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                label: (e['day']as String),
                spendingAmount: (e['amount']as double),
                spendingPctOfTotal: maxSpending==0.0?0.0:(e['amount']as double)/maxSpending),
          );
          }).toList(),
        ),
      ),
    );
  }
}
