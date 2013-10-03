
// datepicker for the index page
$(function() {
  $('#glados3').datepicker().on("changeDate",
	function(dateText, inst) {
	window.location = '<%= people_equipment_path %>' + '?date=' + dateText.format("mm/dd/yyyy");
  	});
});

// datepicker for the show page
$(function() {
  $('#glados3').datepicker().on("changeDate",
function(dateText, inst) {
window.location = '<%= show_person_equipment_path(@person.id) %>' + '?date=' + dateText.format("mm/dd/yyyy");
  });
});
