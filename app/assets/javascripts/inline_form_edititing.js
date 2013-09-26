$(document).ready(function() {
    $(".myformelement").blur(function(event){
        var on_blur_element_value     = mycheck(this);
        var before_blur_element_value = $(this).data("curr_element");
        if(on_blur_element_value == before_blur_element_value) {
            $(event.target).parent().siblings().attr('class', "editable isvisible");
            $(event.target).parent().attr('class', "editable ishidden");
            $(this).data("curr_element")
          } else {
            event.preventDefault();
          };
    });

    var mycheck = function checkSelect(var1){
        var ctrl = $(var1)
        if( ctrl.is('select') ) {
            var myvalue = $(var1).find('option:selected').text();
          } else {
           var myvalue = $(var1).val();
          };
        return myvalue
       }

    $(".myformelement").change(function(event){
        event.preventDefault();
        var myhiddendiv = $(event.target).parent().siblings();
        var valuesToSubmit = $(this).closest('form.editableform').serializeArray();
        var myvalue = mycheck(this);
        $.ajax({
            type: "PUT",
            url: $(this).closest('form.editableform').attr('action'),
            data: valuesToSubmit,
            dataType: "json",
            error: function(xhr){
              var err = $.parseJSON(xhr.responseText).errors
              var errors = err['name'];
              $('div.flash-notice.hidden').text(errors).attr('class', "div flash-notice flash-error visible");
              $(event.target).addClass("myelement-error");// add red border and class name
            },
            success: function(message){
              $('div.flash-notice.hidden').text("Your data was updated").attr('class', "div flash-notice flash-success visible");
              $(event.target).removeClass("myelement-error"); // remove red border
              myhiddendiv.html(myvalue); // update value
              $(event.target).parent().attr('class', "editable ishidden"); // change class and hide element
              myhiddendiv.attr('class', "editable isvisible"); //make div with updated value visible
            }
        });
        return false;
    });

    $(".submit").hide();
    $('div.row:odd').css('background-color', '#f5f5f5' );


    $(".editable.isvisible").dblclick(function(event) {
        var myvalue = $(this).text();
        $('.myformelement').data("curr_element",myvalue);
        $('div.flash-notice').attr('class', "flash-notice hidden");
        $('.editable.isvisible.formelement').attr('class', "editable ishidden"); //hide any visible form elements
        $('.editable.ishidden.currentelement').attr('class', "editable isvisible"); // unhide associated value
        $(event.target).attr('class', "editable ishidden currentelement"); // hide value and tag it current
        var newelement = $(event.target).siblings().attr('class', "editable isvisible formelement"); // make form element visible and tag it
        newelement.children('.myformelement').focus();
    });

});
