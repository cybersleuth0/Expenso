import 'package:flutter/material.dart';

class notificationPage extends StatefulWidget {
  @override
  State<notificationPage> createState() => notificationPage_State();
}

class notificationPage_State extends State<notificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Today",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            leading: Icon(Icons.notifications_active_outlined,
                color: Colors.pinkAccent),
            title: Text("Transaction Added"),
            subtitle: Text("You added ₹500 to Groceries"),
            trailing: Text("10:30 AM",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Yesterday",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded, color: Colors.indigo),
            title: Text("Weekly Limit Crossed"),
            subtitle: Text("You crossed ₹2000 limit"),
            trailing: Text("09:00 PM",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
