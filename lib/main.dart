import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMIPage(),
    );
  }
}

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}


class _BMIPageState extends State<BMIPage> {

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool _isButtonDisabled = false;
  bool _validate = false;

  String result = '';

  var _blackFocusNode = new FocusNode();

  void calculatorBMI() {
    setState(() {
      if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
        _validate = true;
      } else {
        double height = double.parse(_heightController.text);
        double weight = double.parse(_weightController.text);
        double bmi = calculateBMI(height, weight);
        double bestWeight = ((height % 100) * 9) / 10;

        String record1, record2, record3, advice;

        advice = getAdvice(bestWeight, weight);

        record1 = 'Chỉ số BMI của bạn ${bmi.toStringAsFixed(2)} \n';
        record2 = converBMI(bmi);
        record3 = '\nCân nặng lý tưởng của bạn: $bestWeight kg. $advice';

        result = record1 + record2 + record3;
      }
    });
  }

  double calculateBMI(double height, double weight) {
    return (weight / (((height / 100) * (height / 100))));
  }

  String converBMI(double bmiValue) {
    String result1 = '';
    if (bmiValue < 18.5) {
      result1 = 'Bạn bị suy dinh dưỡng';
    } else if (bmiValue < 25) {
      result1 = 'Thân hình bạn hoàn toàn lý tưởng';
    } else if (bmiValue < 30) {
      result1 = 'Bạn bị tiền béo phì';
    } else if (bmiValue < 35) {
      result1 = 'Bạn bị béo phì loại I';
    } else if (bmiValue < 40) {
      result1 = 'Bạn bị béo phì loại II';
    } else {
      result1 = 'Bạn bị béo phì loại III';
    }
    return result1;
  }

  String getAdvice(double bestWeight, double weight) {
    String result2 = 'Thân hình lý tưởng';
    if (bestWeight < weight) {
      result2 = 'Bạn thừa ${(weight - bestWeight).toStringAsFixed(2)} kg';
    } else if (bestWeight > weight) {
      result2 = 'Bạn thiếu ${(bestWeight - weight).toStringAsFixed(2)} kg';
    }

    return result2;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tính chỉ số BMI'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          FocusScope.of(context).requestFocus(_blackFocusNode);
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('assets/images/background_bmi.png'),
//                fit: BoxFit.cover,
//              )
//          ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container().customContainer(Image.asset(
                    'assets/images/bmi.png', width: 200, height: 100,),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container().customContainer(
                            TextField().customTextField(
                                'Chiều cao (cm)',
                                _heightController)),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container().customContainer(
                            TextField().customTextField(
                                'Cân nặng (kg)',
                                _weightController)),
                      ),
                    ],
                  ),
                  Container().customContainer(RaisedButton(
                    onPressed: _isButtonDisabled ? null : calculatorBMI,
                    child: const Text(
                      'Xem Kết Quả',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),),
                  Container(
                    color: Colors.greenAccent,
                    padding: EdgeInsets.all(10),
                    width: 350,
                    height: 150,
                    child: Text(
                      '$result',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}

extension ExtTextField on TextField {
  TextField customTextField(String titleText, TextEditingController tedController) =>
      TextField(
        controller: tedController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: titleText,
        ),
      );
}

extension ExtContainer on Container{
  Container customContainer(Widget widget) => Container(
    padding: EdgeInsets.all(10),
    child: widget,
  );
}