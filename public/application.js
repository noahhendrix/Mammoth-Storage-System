$(function(){
  $("#upload input[type=submit]").hide();
  
  $("#upload input[type=file]").change(function(){
    $(this).hide();
    $form = $(this).parent("form")
    $form.find("#status").show();
    $form.submit();
  });
});