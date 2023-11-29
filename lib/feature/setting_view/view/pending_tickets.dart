import 'package:flutter/material.dart';

import '../../../custom/appbar/appbar.dart';

class PendingTickets extends StatefulWidget {
  const PendingTickets({super.key});

  @override
  State<PendingTickets> createState() => _PendingTicketsState();
}

class _PendingTicketsState extends State<PendingTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Column(children: []),
    );
  }
}
