import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/summary.dart';
import '../widgets/summary-item.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  late Summary dataSummary;

  Future getSummary() async {
    var response = await http.get(
      Uri.parse("https://covid19.mathdro.id/api"),
    );
    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    dataSummary = Summary.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Report"),
      ),
      body: FutureBuilder(
          future: getSummary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            }
            return Column(
              children: [
                SummaryItem("Confirmed", "${dataSummary.confirmed.value}"),
                SummaryItem("Deaths", "${dataSummary.deaths.value}"),
              ],
            );
          }),
    );
  }
}
