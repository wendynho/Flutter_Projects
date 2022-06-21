import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  void decrement() {
    setState(() {
      count--;
    });
    print(count);
  }

  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
    print(count);
  }

  bool get isEmpty => count == 0;

  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    print('Build');

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.panrotas.com.br/portal-panrotas-statics/media-files-cache/310693/e8cc153dffd7d2d3b988b1617fb147c4divulgacao36/0,100,2560,1528/1206,720,0.16/0/default.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isFull ? "Lotado!" : "Pode Entrar!",
                style: TextStyle(
                  fontSize: 50,
                  color: isFull ? Colors.red : Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 160,
                  color: isFull ? Colors.red : Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: isEmpty ? null : decrement,
                    style: TextButton.styleFrom(
                      backgroundColor: isEmpty
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white,
                      fixedSize: const Size(100, 100),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Saiu",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  TextButton(
                    onPressed: isFull ? null : increment,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isFull ? Colors.white.withOpacity(0.2) : Colors.white,
                      fixedSize: const Size(100, 100),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Entrou",
                      style: TextStyle(color: Colors.black, fontSize: 25),
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
