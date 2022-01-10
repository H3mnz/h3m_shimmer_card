import 'package:flutter/material.dart';
import 'package:h3m_shimmer_card/h3m_shimmer_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Card Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Card'),
      ),
      body: GridView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) => Column(
          children: [
            Expanded(
              child: ShimmerCard(
                beginAlignment: Alignment.topLeft,
                endAlignment: Alignment.bottomRight,
                backgroundColor: Colors.grey.shade800,
                shimmerColor: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ShimmerCard(
                  height: 48,
                  width: 48,
                  borderRadius: 48,
                  beginAlignment: Alignment.topLeft,
                  endAlignment: Alignment.bottomRight,
                  backgroundColor: Colors.grey.shade800,
                  shimmerColor: Colors.grey.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ShimmerCard(
                              height: 12,
                              beginAlignment: Alignment.topLeft,
                              endAlignment: Alignment.bottomRight,
                              backgroundColor: Colors.grey.shade800,
                              shimmerColor: Colors.grey.shade700,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ShimmerCard(
                              height: 12,
                              beginAlignment: Alignment.topLeft,
                              endAlignment: Alignment.bottomRight,
                              backgroundColor: Colors.grey.shade800,
                              shimmerColor: Colors.grey.shade700,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
