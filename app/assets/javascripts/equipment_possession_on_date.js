// datepicker for the index page
$(function(){
	var curr_date = $("#get_current_date").text();
	var curr_path = $("#get_current_path").text();
	console.log(curr_date);
	$("#my_datepicker").datepicker({
		defaultDate: curr_date,
		dateFormat: "mm-dd-yy",

		onSelect: function(dateText, inst) {
			window.location = curr_path + '?date=' + dateText;
		}
	})
});