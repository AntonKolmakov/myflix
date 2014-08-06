$(document).ready ->
  $(document).bind "ajaxError", "form#new_event", (event, jqxhr, settings, exception) ->
    # note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors $.parseJSON(jqxhr.responseText)

  $("#event_published_on").datepicker dateFormat: "yy-mm-dd"

  $(".calendar").on "click", "tr td", ->
    text = $(this).data("attr")
    $("#event_published_on").val text

(($) ->
  $.fn.modal_success = ->
    
    # close modal
    @modal "hide"
    
    # clear form input elements
    # todo/note: handle textarea, select, etc
    @find("form input[type=\"text\"]").val ""
    
    # clear error state
    @clear_previous_errors()

  $.fn.render_form_errors = (errors) ->
    $form = this
    @clear_previous_errors()
    model = @data("model")
    
    # show error messages in input form-group help-block
    $.each errors, (field, messages) ->
      $input = $("input[name=\"" + model + "[" + field + "]\"]")
      $input.closest(".form-group").addClass("has-error").find(".help-block").html messages.join(" & ")

  $.fn.clear_previous_errors = ->
    $(".form-group.has-error", this).each ->
      $(".help-block", $(this)).html ""
      $(this).removeClass "has-error"
      return

) jQuery