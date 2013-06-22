# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addMotivateLink = (selector) ->
  $(selector).append "<td><a href='javascript:;' class='motivate'>Motivate me!</a></td>"

$(document).ready(

  addMotivateLink "tr"

  # mark task as completed or not
  $("tbody").on "change", "input[type=checkbox]", (event) ->
    name = event.target.name
    checked = event.target.checked

    $.post "/tasks/#{name}/", {_method: 'patch', 'task[completed]': (if checked then 1 else 0)},
      (data, textStatus, jqXHR) ->
        klass = if checked then 'done' else 'todo'
        $("table.#{klass} tbody").append $(event.target).closest("tr").remove()
        $(event.target).closest('tr').find('.title').restInPlace()

  # new task added
  $("#new_task").on "ajax:success",
    (event, data) ->
      $("table.todo tbody").append(data).find('.title:last').restInPlace()
      addMotivateLink "table.todo tbody tr:last"
      $("#task_title").val ''
      $("table.todo tbody tr:last .motivate").click()

  $("tbody").on "ajax:success", ".delete-link",
    (event, data) ->
      $(event.target).closest("tr").remove()

  # motivate link
  $("tbody").on "click", ".motivate", (event) ->
    $.get "/tasks/#{$(event.target).closest('tr').find('input[type=checkbox]').attr('name')}/motivate",
      (data, textStatus, jqXHR) ->
        gif = data
        url = gif.images.fixed_height.url

        img = new Image
        img.src = url
        img.alt = gif.tags
        img.title = gif.tags
        img.id = "motivation"
        $("#motivation").remove()
        $(".task-list").after img

  # on updated title value
  $("tbody").on "success.rest-in-place", ".title", (event) ->
    $(event.target).closest("tr").find(".motivate").click()

)
