class StringFormatter{


  formatString(String s){
      s = s.trim();
      try{
        s = double.parse(s).toStringAsFixed(2);
        var splitIntandDecimal = s.split('.') ;
        String integer = splitIntandDecimal[0];
        String decimal = splitIntandDecimal[1];

        var finalString = '';

        for(var i = integer.length-1; i>=0; i--){
          var str = integer.substring(i);
          finalString = integer[i] + finalString;
          if((str.length) % 3 == 0  && str.length != integer.length){
            finalString = "," + finalString ;
          }


        }

        return "$finalString.$decimal";
      }catch(e){
        return s;
      }


  }
}