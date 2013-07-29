// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require_tree .

$(document).ready(function(){
	// initial_page_state = {
	// 		page_to_load : "/",
	// 		section: "mrg-index",
	// 		div_to_replace: "mrg-content",
	// 		loading_div : "mrg-loading"
	// }
	// history.replaceState(initial_page_state,"My revision guide", null);
	// window.onpopstate = MRG.popStateHandler;
	// handle_ajax_click();
	
});

function handle_ajax_click(){
	$("a.mrg_ajax_load").click(function(){
			href = $(this).attr('href');
			hrefs = href.split("#");
			page_state = { page_to_load: hrefs[0], 
							section: hrefs[1] , 
							div_to_replace: "mrg-content", 
							loading_div : "mrg-loading"
						}
			MRG.load_page(page_state , true)
			return false;
		});
}
var MRG = {
	handle_ajax_click : function(){
		
	},

	load_page : function(page_state , bool_addHistory){
			MRG.show_loading(page_state.loading_div);
			MRG.scroll_to_top();
			$('#'+page_state.div_to_replace).load(page_state.page_to_load + " #"+page_state.section, 
				function(response, status, xhr){
				 if (status == "error") {
					 MRG.hide_loading(page_state.loading_div);
				     MRG.show_error_message();
					 //alert("Sorry but there was an error: " + xhr.status + " " + xhr.statusText);
				}else{
					handle_ajax_click();
					MRG.hide_loading(page_state.loading_div);
					if(bool_addhistory){
						history.pushState(page_state,"page added", page_state.page_to_load);
					}
					
				}
			});
		},
		
	show_loading : function(loading_div){
			$('#'+loading_div).slideDown();
		},
		
	hide_loading : function(loading_div){
		    $('#'+loading_div).slideUp();
		},
		
	show_error_message : function(){
		error_span = "<span id='mrg-error'>An error occured, Please check your internet connection.</span>";
		$("body").append(error_span);
		setTimeout(function(){
				$('#mrg-error').fadeOut(500).remove();
			}, 5000);
		},
		
	scroll_to_top : function(){
			$("html, body").animate({ scrollTop: 0 }, "slow");
		},
	popStateHandler : function(event){
		if(event.state != null){
			MRG.load_page(event.state , false);
			//alert("Yes to pop");
		}else{
			//alert("No to pop");
		}
	}
	}
