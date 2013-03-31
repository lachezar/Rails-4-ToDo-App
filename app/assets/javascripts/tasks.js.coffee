# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(
  $("tbody").on "change", "input[type=checkbox]", (event) ->
    name = event.target.name
    checked = event.target.checked

    $.post "/tasks/#{name}/", {_method: 'patch', 'task[completed]': (if checked then 1 else 0)},
      (data, textStatus, jqXHR) ->
        klass = if checked then 'done' else 'todo'
        $("table.#{klass} tbody").append $(event.target).closest("tr").remove()
        $(event.target).closest('tr').find('.title').restInPlace()


  $("#new_task").on "ajax:success",
    (event, data) ->
      $("table.todo tbody").append(data).find('.title:last').restInPlace()
      $("#task_title").val ''

  $("tbody").on "ajax:success", ".delete-link",
    (event, data) ->
      $(event.target).closest("tr").remove()

)