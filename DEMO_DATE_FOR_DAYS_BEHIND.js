function get_date_for_days_behind (numdays){
        
		var data_calc = new Date();
        data_calc.setDate(data_calc.getDate() - numdays);
		var demo_calc = data_calc.getTime();
		
        return demo_calc;
		
}
