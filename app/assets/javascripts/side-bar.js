$(function(){
	$(".side-bar-item").niceScroll();

	$("li.ur").hover(function(){
		position = $(this).offset();
		$("#hovered-user").offset({top: position.top, left: position.left-335});
		$("#up-img").attr("src", $(this).attr("dt-img"));
		$("#sb-u-n").text($(this).attr("dt-name"));
		$("#sb-u-rank").text("Rank: "+$(this).attr("dt-rank"));
		$("#sb-u-link").attr("href",$(this).attr("dt-link"));
		$("#hovered-user").show();
	}
	);
	$("#hovered-user").hover(function(){
			$("#hovered-user").show();
	}, function(){
		$("#hovered-user").hide();

	});
	
	$(document).click(function(){
		$("#hovered-user").fadeOut();
	});
});