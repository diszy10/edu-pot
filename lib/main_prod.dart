import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/config/prod.dart';

import './main.dart';

void main() {
  Config().loadFromMap(settings);
  baseMain();
}