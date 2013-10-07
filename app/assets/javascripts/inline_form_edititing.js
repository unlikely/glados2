$(document).ready(function() {
    $(".myformelement").blur(function(event){
        var on_blur_element_value     = mycheck(this);
        var before_blur_element_value = $(this).data("curr_element");
        if(on_blur_element_value == before_blur_element_value) {
            $(event.target).parent().siblings().removeClass("currentelement ishidden").addClass("isvisible");
            $(event.target).parent().removeClass("isvisible").addClass("ishidden");
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
        var url = $(this).closest('form.editableform').attr('action');
        $.ajax({
            type: "PUT",
            url: $(this).closest('form.editableform').attr('action'),
            data: valuesToSubmit,
            dataType: "json",
            error: function(xhr){
              var err = $.parseJSON(xhr.responseText).errors
              console.log(err);
                for (i in err){
                  console.log(i)
                  for(n in err[i]){
                    console.log(err[i][n])
                    $('div.some_alert').append('<div class="alert alert-error">' + i + ': ' + err[i][n] + '</div>');
                  }
                }


              $(event.target).addClass("myelement-error");// add red border and class name
            },
            success: function(message){
              $('div.alert').remove();
              $('div.some_alert').append('<div class="alert alert-success"> Your data updated successfully</div>');
              $(event.target).removeClass("myelement-error"); // remove red border
              var parent = $(event.target).parent().removeClass("isvisible").addClass("ishidden");
              myhiddendiv.html(myvalue).removeClass("currentelement ishidden").addClass("isvisible"); // update value
            }
        });
        return false;
    });

    $(".submit").hide();
    $('div.row.mytable:odd').css('background-color', '#f5f5f5' );


    $(".editable.isvisible").dblclick(function(event) {
        var myvalue = $(this).text();
        $('.myformelement').data("curr_element",myvalue);
        $('div.alert').remove();
        $('.editable.isvisible.formelement').removeClass("isvisible").addClass("ishidden"); //hide any visible form elements
        $(event.target).removeClass("isvisible").addClass("currentelement ishidden"); // hide value and tag it current
        var newelement = $(event.target).siblings().removeClass("ishidden").addClass("isvisible formelement"); // make form element visible and tag it
        newelement.children('.myformelement').focus();
    });
});
