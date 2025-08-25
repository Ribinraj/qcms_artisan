import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms_artisan/core/colors.dart';


class Customloginloadingbutton extends StatelessWidget {
  const Customloginloadingbutton({
    super.key,
  
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed:(){},
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.kprimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child:SpinKitWave(size: 20,color:Appcolors.kwhitecolor,),
      ),
    );
  }
}
