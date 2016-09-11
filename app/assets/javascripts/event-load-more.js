$(document).on("turbolinks:load", function() {
  if($("#event-load-more").length > 0){
    var $btn = $("#event-load-more")
    var event_per_page = $btn.data("perpage");
    var event_count = $btn.data("fpcount");
    var event_loading = false;
    var event_till_id = $btn.data("tillid");
    var url = $btn.data("url");
    var event_no_more = event_count < event_per_page;
    if(event_no_more){
      $btn.html("没有了").removeClass("btn-primary")
    }
    function load_more_events(){
      if(!event_loading && !event_no_more){
        event_loading = true;
        $btn.html("加载中...")
        $.ajax({
          url: url,
          type: "get",
          dataType: "html",
          data: { till_id: event_till_id },
          success: function(data){
            var new_events = $(data)
            $(".table.events-table > tbody").append(new_events)
            event_till_id = $(".table.events-table > tbody > .event:last-child").data("id")
            event_loading = false
            $btn.html("加载更多")
            if(new_events.length < event_per_page){
              event_no_more = true
              $btn.html("没有了").removeClass("btn-primary")
            }
          }
        })
      }
    }
    $btn.bind("onclick", load_more_events)
    function scroll_listener(){
      if($(window).scrollTop() > $(document).height() - $(window).height() - 60){
        load_more_events()
      }
    }
    $(document).bind('scroll', scroll_listener)
    $(document).one("turbolinks:before-visit", function(){
      $btn.unbind("onclick", load_more_events)
      $(document).unbind('scroll', scroll_listener)
    })
  }
})