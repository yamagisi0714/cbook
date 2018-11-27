console.log("a")
$ ->
  $('.table-sortable').sortable
    axis: 'y'
    items: '.item'
    update: (e, ui) ->
      item = ui.item
      item_data = item.data()
      console.log(params)
      params = { _method: 'put' }
      params["step"] = { procedure_num_position: item.index() }
      $.ajax
        type: 'PUT'
        url: item_data.updateUrl
        dataType: 'json'
        data: params
        start: (e, ui) ->
      tableWidth = $(this).width()
      cells = ui.item.children('td')
      widthForEachCell = tableWidth / cells.length + 'px'
      cells.css('width', widthForEachCell)