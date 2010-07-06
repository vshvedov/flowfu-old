$(document).ready(function() {
// Switch categories
  $('#h-wrap').hover(function(){
      $(this).toggleClass('active');
      $("#h-wrap ul").css('display', 'block');
    }, function(){
      $(this).toggleClass('active');
      $("#h-wrap ul").css('display', 'none');
  });
// Handling with tables (adding first and last classes for borders and adding alternate bgs)
  $('tbody tr:even').addClass('even');
  $('table.grid tbody tr:last-child').addClass('last');
  $('tr th:first-child, tr td:first-child').addClass('first');
  $('tr th:last-child, tr td:last-child').addClass('last');
  $('form.fields fieldset:last-child').addClass('last');
// Handling with lists (alternate bgs)
  $('ul.simple li:even').addClass('even');
// Handling with grid views (adding first and last classes for borders and adding alternate bgs)
  $('.grid .line:even').addClass('even');
  $('.grid .line:first-child').addClass('firstline');
  $('.grid .line:last-child').addClass('lastline');
// Tabs switching
  $('#box1 .content#box1-grid').hide(); // hide content related to inactive tab by default
  $('#box1 .header ul a').click(function(){
    $('#box1 .header ul a').removeClass('active');
    $(this).addClass('active'); // make clicked tab active
    $('#box1 .content').hide(); // hide all content
    $('#box1').find('#' + $(this).attr('rel')).show(); // and show content related to clicked tab
    return false;
  });

  log = function(obj){
    if ( typeof window.console != "undefined" && typeof window.console.log == "function" ){
      window.console.log(obj)
    }else if ( debugging && print == "function" ){
      print(obj)
    }
  }
  dir = function(obj){
    if ( typeof window.console != "undefined" && typeof window.console.log == "function" ){
      window.console.dir(obj)
    }else if ( debugging && print == "function" ){
      print(obj)
    }
  }
  error = function(message){
    alert(message)
  }

  //Tooltips for task description

  $("#tasks .task_name").tooltip({
    tip: '.task_descr',
    position: 'bottom left',
    offset: [4,480],
    effect: 'fade',
    fadeInSpeed: 200,
    fadeOutSpeed: 0,
    direction: 'down'
  });

  //Tooltips for upload description

  $("#uploads a.upload").tooltip({
    tip: '.upload_descr',
    position: 'center left',
    effect: 'slide'
  });
});
