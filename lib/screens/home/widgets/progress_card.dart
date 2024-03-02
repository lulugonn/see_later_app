import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';

class ProgressCard extends StatefulWidget {
  ProgressCard({super.key});

  final ContentModel content =
      ContentModel(title: "Luana", url: "Luana", notes: "asda");

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    // return ContentCard(content: widget.content );
    return Card(
      color: Global.offwhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Progresso de consumo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "Confira quanto conteúdo salvo você já visualizou",
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      "50%",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: 70,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    // return Card(

    //   child: Padding(
    //     padding: const EdgeInsets.all(25),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,

    //     ]),
    //   ),
    // );
  }
}
