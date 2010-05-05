jQuery(function($) {
  $("#ajax-indicator").ajaxStart(function(){ $(this).show();  });
  $("#ajax-indicator").ajaxStop(function(){ $(this).hide();  });

  attachSortables = function() {
    $('#prioritized-versions ol').sortable({
      cancel: 'a',
      connectWith: ["#unprioritized-versions ul"],
      placeholder: 'drop-accepted',
      dropOnEmpty: true,
      // Allow drag and drop inside the list
      update: function (event, ui) {
        if (ui.sender == null && event.target == this) {
          saveOrder();
        }
      },
      receive: function (event, ui) {
        saveOrder();
      }
    });

    $('#unprioritized-versions ul').sortable({
      cancel: 'a',
      connectWith: ["#prioritized-versions ol"],
      placeholder: 'drop-accepted',
      dropOnEmpty: true
    });

  },

  saveOrder = function() {
    var data = $('#prioritized-versions ol').sortable('serialize')

    $.ajaxQueue.put('version_priorities.js', {
      data: addAuthenticityToken(data),
      success: function(response) {
        $('#prioritized-versions').html(response);
      },
      error: function(response) {
        $("div.error").html("Error saving lists.  Please refresh the page and try again.").show();

      }
    });
  },

  addAuthenticityToken = function(data) {
    return data + '&authenticity_token=' + encodeURIComponent(window._token);
  },

  attachSortables();
});
