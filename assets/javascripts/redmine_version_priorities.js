jQuery(function($) {
  $("#ajax-indicator").ajaxStart(function(){ $(this).show();  });
  $("#ajax-indicator").ajaxStop(function(){ $(this).hide();  });

  attachSortables = function() {
    $('#prioritized-versions ol').sortable({
      cancel: 'a',
      connectWith: ["#unprioritized-versions ul"],
      placeholder: 'drop-accepted',
      dropOnEmpty: true,
      update: function (event, ui) {
        alert('saved');
      }
    });

    $('#unprioritized-versions ul').sortable({
      cancel: 'a',
      connectWith: ["#prioritized-versions ol"],
      placeholder: 'drop-accepted',
      dropOnEmpty: true,
      update: function (event, ui) {
        alert('saved');
      }
    });

  },

  attachSortables();
});
