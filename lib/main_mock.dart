import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/config/mock.dart';

import './main.dart';

void main() {
  Config().loadFromMap(settings);
  baseMain();
}