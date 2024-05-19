import 'package:e_commerce_app/consts/consts.dart';

Widget bgWidet({Widget? child}){
  return Container(
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}