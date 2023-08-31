import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final List<PieData> pies = [
    PieData(value: 0.15, color: Colors.yellow),
    PieData(value: 0.35, color: Colors.cyan),
    PieData(value: 0.45, color: Colors.lightGreen),
  ];
  String tapIndex = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Demo Pie Chart')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CustomCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EasyPieChart(
                      key: const Key('pie 1'),
                      children: pies,
                      borderEdge: StrokeCap.butt,
                      pieType: PieType.crust,
                      onTap: (index) {},
                      style: const TextStyle(
                          color: Colors.pinkAccent, fontSize: 10),
                      gap: 0.02,
                      start: 0,
                      size: 130,
                    ),
                    EasyPieChart(
                      key: const Key('pie 2'),
                      children: pies,
                      pieType: PieType.crust,
                      onTap: (index) {
                        tapIndex = index.toString();
                        setState(() {});
                      },
                      gap: 0.1,
                      start: 0,
                      animateFromEnd: true,
                      size: 130,
                      child: Center(child: Text(tapIndex)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EasyPieChart(
                      key: const Key('pie 3'),
                      children: pies,
                      borderEdge: StrokeCap.butt,
                      borderWidth: 10,
                      pieType: PieType.triCrust,
                      onTap: (index) {},
                      size: 130,
                    ),
                    EasyPieChart(
                      key: const Key('pie 4'),
                      children: pies,
                      pieType: PieType.triCrust,
                      onTap: (index) {},
                      animateFromEnd: true,
                      borderWidth: 10,
                      size: 130,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EasyPieChart(
                      key: const Key('pie 5'),
                      children: pies,
                      pieType: PieType.fill,
                      onTap: (index) {},
                      start: 180,
                      size: 130,
                    ),
                    EasyPieChart(
                      key: const Key('pie 6'),
                      children: pies,
                      pieType: PieType.fill,
                      onTap: (index) {},
                      start: 180,
                      animateFromEnd: true,
                      size: 130,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  const CustomCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(padding: const EdgeInsets.all(20.0), child: child));
  }
}
