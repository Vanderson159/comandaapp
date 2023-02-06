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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: lembrar,
          onChanged: _lembrarCheck,
          activeColor: Colors.grey.shade300,
          checkColor: Colors.black,
        ),
        const Text('Lembrar meus dados'),
        const SizedBox(width: 30),
        GestureDetector(
            child: const Text(
                'Esqueci minha senha.',
              style: TextStyle(
                color: Colors.red
              ),
            ),
        ),
      ],
    );
  }
  void _lembrarCheck(novoValor){
    setState(() {
      lembrar = novoValor;

      if(lembrar){
        //TODO: Lembrar dados
      }
      else{
        //TODO: Não lembrar dados
      }
    });
  }
}
