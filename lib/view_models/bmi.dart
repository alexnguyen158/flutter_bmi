import 'package:rxdart/rxdart.dart';
import '../helper/validation.dart';

class BMIViewModel{
  final _heightSubject = BehaviorSubject<String>();
  final _weightSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  Stream<String> get heightStream => _heightSubject.stream;
  Sink<String> get heightSink => _heightSubject.sink;

  Stream<String> get weightStream => _weightSubject.stream;
  Sink<String> get weightSink => _weightSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  BMIViewModel(){
    Rx.combineLatest2(_heightSubject, _weightSubject, (height, weight) {
      return Validation.validationHeight(height) == null &&
          Validation.validationWeight(weight) == null;
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  dispose(){
    _heightSubject.close();
    _weightSubject.close();
    _btnSubject.close();
  }

}