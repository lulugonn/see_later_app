import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';

class ProgressCard extends StatefulWidget {
  ProgressCard({super.key});

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Future<double?> _progress;

  Future<double?> _getProgress() async {
    return APIService().getProgress();
  }

  @override
  void initState() {
    super.initState();
    _progress = _getProgress();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
      future: _progress,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          double progressValue = snapshot.data ?? 0.0;
          if (progressValue != 0) {
            if (_controller == null ||
                _controller!.upperBound != progressValue) {
              _controller?.dispose();
              _controller = AnimationController(
                duration: const Duration(seconds: 5),
                vsync: this,
                upperBound: progressValue,
              )..forward();
            }

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "Confira quanto conteúdo salvo você já visualizou",
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              "${(progressValue * 100).toStringAsFixed(1).replaceAll(".", ",")}%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            AnimatedBuilder(
                              animation: _controller!,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              builder: (context, child) {
                                return ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: _controller!.value,
                                    minHeight: 12,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Global.green),
                                    backgroundColor: Global.grey,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "Confira quanto conteúdo salvo você já visualizou",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            "0%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: LinearProgressIndicator(
                                  value: 0,
                                  minHeight: 12,
                                  backgroundColor: Global.grey,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          // Initialize the AnimationController with the fetched upperBound
        }
        return Container();
      },
    );
  }
}
