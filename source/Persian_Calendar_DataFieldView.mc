using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;

class Persian_Calendar_DataFieldView extends Ui.SimpleDataField {

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Date";
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method. 
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.
                
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var result = gregorian_to_jalali(today.year,get_month_number(today.month),today.day,false);
        return result[1] + "/" + result[2];
    }
    
    
    function div(a,b) { 
    	return (a / b); 
	} 
	
	function get_month_number(month) {
		switch (month) {
			case "Jan": return 1; break;
			case "Feb": return 2; break;
			case "Mar": return 3; break;
			case "Apr": return 4; break;
			case "May": return 5; break;
			case "Jun": return 6; break;
			case "Jul": return 7; break;
			case "Aug": return 8; break;
			case "Sep": return 9; break;
			case "Oct": return 10; break;
			case "Nov": return 11; break;
			case "Dec": return 12; break;
		}
	}	
	    
	function gregorian_to_jalali (g_y, g_m, g_d,str) 
	{ 

		var i;
	    var g_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 
	    var j_days_in_month = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]; 
	 
	  
	   var gy = g_y-1600; 
	   var gm = g_m-1; 
	   var gd = g_d-1; 
	 
	   var g_day_no = 365*gy+div(gy+3,4)-div(gy+99,100)+div(gy+399,400); 
	 
	   for (i=0; i < gm; ++i) {
	      g_day_no += g_days_in_month[i]; 
	   }
	   if (gm>1 && ((gy%4==0 && gy%100!=0) || (gy%400==0))) {
	      /* leap and after Feb */ 
	      g_day_no = g_day_no + 1; 
	   }
	   g_day_no += gd; 
	 
	   var j_day_no = g_day_no-79; 
	 
	   var j_np = div(j_day_no, 12053); /* 12053 = 365*33 + 32/4 */ 
	   j_day_no = j_day_no % 12053; 
	 
	   var jy = 979+33*j_np+4*div(j_day_no,1461); /* 1461 = 365*4 + 4/4 */ 
	 
	   j_day_no %= 1461; 
	 
	   if (j_day_no >= 366) { 
	      jy += div(j_day_no-1, 365); 
	      j_day_no = (j_day_no-1)%365; 
	   } 
	 
	   for (i = 0; i < 11 && j_day_no >= j_days_in_month[i]; ++i) {
	      j_day_no -= j_days_in_month[i]; 
	   }
	   var jm = i+1; 
	   var jd = j_day_no+1; 
	   
	   if(str) {
	      return jy+"/"+jm+"/"+jd ;
	   }
	   var array = [jy,jm,jd];
	   return array; 
	}     

}