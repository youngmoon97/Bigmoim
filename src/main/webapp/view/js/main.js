$(function() {
	'use strict';

  $('.form-control').on('input', function() {
	  var $field = $(this).closest('.sign-nameHeader');
	  if (this.value) {
	    $field.addClass('field--not-empty');
	  } else {
	    $field.removeClass('field--not-empty');
	  }
	});

});
