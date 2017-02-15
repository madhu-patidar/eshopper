// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require country_state_select
//= require chosen-jquery
//= require scaffold
//= require_tree .



function update_quantity(cart_item_id,product_id,min,max,qty) 
{ 
  var quantity = $("#cart-item-"+cart_item_id).val();

  if (quantity <= max && quantity >= min) 
  {
    $.ajax({
      type: "PUT",
      url: "/cart_items/"+cart_item_id,
      dataType : 'script',
      data: {'product_id':product_id,'quantity' :quantity}
    });
  }
  else 
  {
    $("#cart-item-"+cart_item_id).val(qty);
    alert("Quantity should be between "+min+"and "+max)
  };
};

function show(url) 
{
  $("#foo").attr("src", url); 
};

$(document).ready(function(){
    $('[data-toggle="popover"]').popover();   
});
// $(document).on('ready page:load', function() {
//   return CountryStateSelect({
//     country_id: "address_country",
//     state_id: "address_state"
//   });
// });