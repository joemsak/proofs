var framed = 100;
var matted = 30;
var qty = 0;
jQuery.noConflict();
jQuery(document).ready(function($){
	$(window).load(function(){
		$('#photo,#thumbs,#controls,.ss-controls,.nav-controls').fadeIn();
	});
	
	$('#sub-content').galleriffic('#thumbs', {
			delay:                4000,
			numThumbs:            12,
			preloadAhead:         12, // Set to -1 to preload all images
			enableTopPager:       false,
			nextPageLinkText:			'More',
			prevPageLinkText:			'Back',
			enableBottomPager:    true,
			imageContainerSel:    '#photo',
			controlsContainerSel: '#controls',
			captionContainerSel:	'#caption',
			enableHistory:        true,
			onChange:							function(prevIndex, nextIndex) {
															$('#thumbs ul.thumbs').children().eq(prevIndex).fadeTo('fast', 0.67).end().eq(nextIndex).fadeTo('fast', 1.0);
														},
			onTransitionOut:      function(callback) {
															$('#photo').fadeOut('fast', callback);
														},
			onTransitionIn:       function() {
															$('#photo').fadeIn('fast');
															bindLineItemForm($('#quantity').val(), $('#size_option').val().split('_')[1]);
															$('#submitBtn').val('Add to Cart').removeAttr('disabled');
															$('#added_msg').remove();
														}
	});
		
	var ctime;
	
	$('#png').mouseenter(function(){
		clearTimeout(ctime);
		$('#caption').slideDown();
	}).mouseleave(function(){
		ctime = setTimeout("jQuery('#caption').slideUp();", 3000);
	});
		
});

function bindLineItemForm(qty, size_price){
	//alert(qty + ' ' + size_price);
	addUp(qty, size_price);
	
	jQuery('#quantity').keyup(function(){
		jQuery('#submitBtn').val('Add to Cart').removeAttr('disabled');
		jQuery('#added_msg').remove();
		qty = jQuery(this).val();
		addUp(qty, size_price);
	});
	
	jQuery('#line_item_framed_framed, #line_item_framed_matted, #line_item_framed_niether').click(function(){
		qty = jQuery('#line_item_quantity').val();
		addUp(qty, size_price);
	});
	
	jQuery('#size_option').change(function(){
		jQuery('#submitBtn').val('Add to Cart').removeAttr('disabled');
		jQuery('#added_msg').remove();
		jQuery('#quantity, #size_option').unbind();
		bindLineItemForm(jQuery('#quantity').val(), jQuery('#size_option').val().split('_')[1]);
	});
	
}

function addUp(qty, size_price){
	var price = 0;
	price += qty*size_price;
	if(jQuery('#line_item_framed_framed:checked').length > 0 && qty > 0){
		price += framed*qty;
	} else if(jQuery('#line_item_framed_matted:checked').length > 0 && qty > 0){
		price += matted*qty;
	}
	jQuery('#photo_price').html(price);
}
