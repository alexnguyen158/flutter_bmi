import 'package:flutter/material.dart';
import '../view_models/bmi.dart';


class BMIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator BMI'),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}


class _BodyWidgetState extends State<BodyWidget> {

  final edtHeightController = TextEditingController();
  final edtWeightController = TextEditingController();
  String _txtResultString = 'Nhập chiều cao (cm) và cân nặng (kg) của bạn để xem kết quả!';

  final bmiViewModel = BMIViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    edtHeightController.addListener(() {
      bmiViewModel.heightSink.add(edtHeightController.text);
    });

    edtWeightController.addListener(() {
      bmiViewModel.weightSink.add(edtWeightController.text);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_bmi.png'),
            fit: BoxFit.cover,
          )
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: edtHeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Chiều cao (cm)',
                          labelText: 'Chiều cao (cm)',
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextField(
                        controller: edtWeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Cân nặng (cm)',
                          labelText: 'Cân nặng (cm)',
                        ),
                      ),
                    )
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10),),
            SizedBox(
              width: 180,
              height: 60,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: (){

                },
                child: Text(
                  'XEM KẾT QUẢ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10),),
            Text(
              _txtResultString,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

