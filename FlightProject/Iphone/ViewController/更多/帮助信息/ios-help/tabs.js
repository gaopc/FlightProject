// JavaScript Document
$(function(){
	$('.help_tt').click(function(){
		var divBlock = $(this).next('div');
		if(divBlock.is(":hidden")){
			divBlock.slideDown(300).end().parent('.parentdiv').siblings().find('.plane_infor').slideUp(300);
			}
		else if(divBlock.is(":visible")){
			divBlock.slideUp(300);
			}
		})
	})