$(document).ready(function() {
    $(".myformelement").blur(function(event){
        $(event.target).parent().siblings().attr('class', "editable isvisible");
        $(event.target).parent().attr('class', "editable ishidden");
    });

    $(".myformelement").change(function(event){
        event.preventDefault();
        var myvalue = $(this).val();
        var myhiddendiv = $(event.target).parent().siblings();
        var valuesToSubmit = $(this).closest('form.editableform').serializeArray();

        $.ajax({
            type: "PUT",
            url: $(this).closest('form.editableform').attr('action'),
            data: valuesToSubmit,
            dataType: "json",
            error: function(error){
              var blah = error['responseText']["errors"];
              $('div.flash-error.hidden').text("something is written").attr('class', "div flash-error visible");
              console.debug(blah);
              $(event.target).addClass("myelement-error");// add red border and class name
            },
            success: function(message){
              $('div.flash-success.hidden').text("Your data was updated").attr('class', "div flash-success visible");
              $(event.target).removeClass("myelement-error"); // remove red border
              myhiddendiv.html(myvalue); // update value
              $(event.target).parent().attr('class', "editable ishidden"); // change class and hide element
              myhiddendiv.attr('class', "editable isvisible"); //make div with updated value visible
              console.debug("As far as I can tell you have been updated");
            }
        });
        return false;
    });

    $(".submit").hide();


    $(".editable.isvisible").dblclick(function(event) {
        $('.editable.isvisible.formelement').attr('class', "editable ishidden"); //hide any visible form elements
        $('.editable.ishidden.currentelement').attr('class', "editable isvisible"); // unhide associated value
        $(event.target).attr('class', "editable ishidden currentelement"); // hide value and tag it current
        var newelement = $(event.target).siblings().attr('class', "editable isvisible formelement"); // make form element visible and tag it
        newelement.children('.myformelement').focus();
    });

});
