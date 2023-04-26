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
  
	// show-comments 버튼 요소를 선택합니다.
	const showCommentsButton = document.querySelector('.show-comments');
  
	// showComments 함수를 정의합니다.
	function showComments() {
	  // post-container 요소에서 comments 클래스를 가진 요소를 선택합니다.
	  const comments = document.querySelector('.post-container .comments');
  
	  // comments 요소가 보이지 않는 상태라면 보이게 하고, 그렇지 않은 경우에는 숨깁니다.
	  if (comments.style.display === 'none') {
		comments.style.display = 'block';
	  } else {
		comments.style.display = 'none';
	  }
	}
  
	// show-comments 버튼에 클릭 이벤트 리스너를 추가합니다.
	showCommentsButton.addEventListener('click', showComments);
  
  });
  