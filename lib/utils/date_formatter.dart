import 'package:intl/intl.dart';

class FormatDate{


  formatDate(String date){
    var myDate = DateTime.parse(date);
    var formatter = new DateFormat('dd MMM yyyy');
    String formatted = formatter.format(myDate);
    return formatted;
  }

}