import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Insertar cuadrado o triángulo',
            style: TextStyle(color: Color.fromARGB(255, 255, 248, 248)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _figure = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text(
            '¿Qué figura va querer nene?',
          style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 18),
          TextField(
            onChanged: (value) {
              setState(() {
                _figure = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Escriba aquí rey',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // No es necesario realizar el conteo, solo mostrar la figura
            },
            child: const Text('Awevo, siguiente'),
          ),
          const SizedBox(height: 20),
          CustomPaint(
            size: Size(300, 300), // Tamaño del área de dibujo
            painter: _FigurePainter(figure: _figure), // Llamamos al painter con la figura actual
          ),
        ],
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  final String figure;

  _FigurePainter({required this.figure});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    switch (figure.toLowerCase()) {
      case 'triángulo':
        _drawTriangle(canvas, paint, center, size.width / 3);
        break;
      case 'cuadrado':
        _drawSquare(canvas, paint, center, size.width / 3);
        break;
      default:
        _drawText(canvas, paint, center, 'La figura no se encontró muñeco');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawTriangle(Canvas canvas, Paint paint, Offset center, double side) {
    final path = Path();
    path.moveTo(center.dx, center.dy - side / 2);
    path.lineTo(center.dx + side / 2, center.dy + side / 2);
    path.lineTo(center.dx - side / 2, center.dy + side / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSquare(Canvas canvas, Paint paint, Offset center, double side) {
    final rect = Rect.fromCenter(center: center, width: side, height: side);
    canvas.drawRect(rect, paint);
  }

  void _drawText(Canvas canvas, Paint paint, Offset center, String text) {
    final textStyle = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textOffset = Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }
}