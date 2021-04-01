import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 215, 215, 215)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.17,size.height*0.07);
    path_0.cubicTo(size.width*0.30,size.height*0.07,size.width*0.50,size.height*0.22,size.width*0.50,size.height*0.59);
    path_0.cubicTo(size.width*0.50,size.height*0.80,size.width*0.40,size.height*1.12,size.width*0.17,size.height*1.12);
    path_0.cubicTo(size.width*0.04,size.height*1.12,size.width*-0.16,size.height*0.96,size.width*-0.17,size.height*0.59);
    path_0.cubicTo(size.width*-0.16,size.height*0.39,size.width*-0.07,size.height*0.07,size.width*0.17,size.height*0.07);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  

  Paint paint_1 = new Paint()
      ..color = Color.fromARGB(164, 243, 82, 33)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path_1 = Path();
    path_1.moveTo(size.width*0.13,size.height*-0.19);
    path_1.cubicTo(size.width*0.27,size.height*-0.18,size.width*0.49,size.height*-0.03,size.width*0.49,size.height*0.38);
    path_1.cubicTo(size.width*0.49,size.height*0.60,size.width*0.38,size.height*0.94,size.width*0.13,size.height*0.94);
    path_1.cubicTo(size.width*-0.01,size.height*0.94,size.width*-0.22,size.height*0.77,size.width*-0.22,size.height*0.38);
    path_1.cubicTo(size.width*-0.22,size.height*0.16,size.width*-0.12,size.height*-0.18,size.width*0.13,size.height*-0.19);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  

  Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path_2 = Path();
    path_2.moveTo(size.width*0.03,size.height*-0.15);
    path_2.cubicTo(size.width*0.19,size.height*-0.15,size.width*0.42,size.height*0.02,size.width*0.42,size.height*0.46);
    path_2.cubicTo(size.width*0.42,size.height*0.70,size.width*0.31,size.height*1.08,size.width*0.03,size.height*1.08);
    path_2.cubicTo(size.width*-0.12,size.height*1.08,size.width*-0.35,size.height*0.89,size.width*-0.36,size.height*0.46);
    path_2.cubicTo(size.width*-0.35,size.height*0.22,size.width*-0.24,size.height*-0.15,size.width*0.03,size.height*-0.15);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
