import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  const TransactionList(
      {required this.transaction, required this.deleteTx, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: const [
              Text('No Transaction added yet!'),
            ],
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${transaction[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTx(transaction[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          label: const Text('Delete',style: TextStyle(
                            color: Colors.redAccent
                          ),))
                      : IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            deleteTx(transaction[index].id);
                          },
                        ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //         padding: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Theme.of(context).primaryColor,
              //               width: 2),
              //         ),
              //         child: Text(
              //           '\$${transaction[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Theme.of(context).primaryColor),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transaction[index].title,
              //             style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //           ),
              //           Text(
              //             DateFormat.yMMMd().format(transaction[index].date),
              //             style: TextStyle(color: Colors.grey),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            // children: [
            //   ...transaction.map((tx) {
            // return Card(
            //   child: Row(
            //     children: [
            //       Container(
            //         child: Text(
            //           '\$${tx.amount}',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 20,
            //               color: Colors.purple),
            //         ),
            //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.purple, width: 2),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             tx.title,
            //             style:
            //                 TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //           ),
            //           Text(
            //             DateFormat.yMMMd().format(tx.date),
            //             style: TextStyle(color: Colors.grey),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // );
            //   }).toList()
            // ],
          );
  }
}
