// This is where it all goes :)
$("#js-submit").submit(function (e) {
  e.preventDefault()

  var $form = $(this);
  $.post($form.attr('action'), $form.serialize()).then(function () {
    alert('Thanks for subscribing!')
  });
});
