$(document).ready(function(){
  $('.new_rating').on('submit', function(event){
    var $button = $(this).find('button');
    var $score = $(this).closest('.link').find('.link-score');
    var current_score = parseInt($score.text(), 10);

    $button.prop('disabled', true);

    $.post("/ratings.json", $(this).serialize())
      .done(function(data) {
        $score.text(current_score + 1);
      })
      .fail(function(data) {
        $button.prop('disabled', false);
      });

    event.preventDefault();
    return false;
  });
});
