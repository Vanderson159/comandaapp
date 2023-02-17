import 'package:flutter/material.dart';


class RememberData extends StatefulWidget {
  const RememberData({Key? key}) : super(key: key);

  @override
  State<RememberData> createState() => _RememberDataState();
}

class _RememberDataState extends State<RememberData> {

  bool lembrar = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 35,
          child: Checkbox(
            value: lembrar,
            onChanged: (value){
              setState(() {
                lembrar = value!;

                if(lembrar){
                  //TODO: Lembrar dados
                }
                else{
                  //TODO: Não lembrar dados
                }
              });
            },
            activeColor: Colors.grey.shade300,
            checkColor: Colors.black,
          ),
        ),
        const Text('Lembrar de mim'),
      ],
    );
  }

}
