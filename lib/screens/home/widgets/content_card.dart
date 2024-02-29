import 'package:flutter/material.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({super.key, required this.title, required this.notes, required this.url});
  final String title;
  final String notes;
  final String url;


  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Icon(
            Icons.link,
            size: 30,
          ),
          title: Text(widget.title),
          subtitle: Text(
            "${widget.url} \n ${widget.notes}" ,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Icon(Icons.delete),
          isThreeLine: true,
        ),
      ),
    );
  }
}
