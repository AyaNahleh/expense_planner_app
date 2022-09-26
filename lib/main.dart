import 'dart:io';
import 'package:expenseplanner/widgets/chart.dart';
import 'package:expenseplanner/widgets/new_transaction.dart';
import 'package:expenseplanner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  // you need to put this line before because some devices not working with system chrome
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
    //its not allow you to rotate your phone
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expensive',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     titleMedium: TextStyle(
        //       fontFamily: 'ex'
        //     )
        //   ) this is for appbar theme
        // )
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
   final isLandscape =mediaQuery.orientation==Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expensive'),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add))
      ],
    );
    final pageBody=SingleChildScrollView(
      // scroll should always be inside container or in body itself or put listview
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //this way you don't have tp put else
          if(isLandscape)Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch.adaptive(value: _showChart, onChanged: (val){
                setState((){
                  _showChart=val;
                });
              })
            ],
          ),
          if(!isLandscape)Container(
              height: (mediaQuery.size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
              child: Chart(recentTransaction: _recentTransaction)),
          if (!isLandscape)Container(
            height: (mediaQuery.size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
            child: TransactionList(
                transaction: _userTransactions, deleteTx: _deleteTransaction),
          ),

          if(isLandscape) _showChart?Container(
              height: (mediaQuery.size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
              child: Chart(recentTransaction: _recentTransaction)):
          Container(
            height: (mediaQuery.size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
            child: TransactionList(
                transaction: _userTransactions, deleteTx: _deleteTransaction),
          ),
        ],
      ),
    );
    return Platform.isIOS?
    CupertinoPageScaffold(
        child:pageBody,

    ):Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      Platform.isIOS? Container(

      ):FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
