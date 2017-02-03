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
//= require chosen-jquery
//= require_tree .
// $(document).on('ready page:load', function() {
//   return CountryStateSelect({
//     country_id: "country_field_id",
//     state_id: "state_field_id"
//   });
// });


function update_quantity(cart_item_id,product_id,min,max,qty) { 
  var quantity = $("#cart-item-"+cart_item_id).val();
  if (quantity <= max && quantity >= min) {
    $.ajax({
      type: "PUT",
      url: "/cart_items/"+cart_item_id,
      dataType : 'script',
      data: {'product_id':product_id,'quantity' :quantity}
    });}
    else {
      $("#cart-item-"+cart_item_id).val(qty);
      alert("Quantity should be between "+min+"and "+max)
    };
}

$(document).ready(function(){ 
    $('#check-address').click(function(){
        if($('#check-address').is(':checked')){
            $('#name1').val($('#name').val());
            $('#address-field1').val($('#address-field').val());
            $('#address2-field1').val($('#address2-field').val());
            $('#city1').val($('#city').val());
            $('#zip1').val($('#zip').val());
            $('#country1').val($('#country').val());
            $('#mobile_number1').val($('#mobile_number').val());
            
        } else { 
            //Clear on uncheck
            $('#name1').val("");
            $('#address-field1').val("");
            $('#address2-field1').val("");
            $('#city1').val("");
            $('#zip1').val("");
            $('#mobile_number1').val("");
        };

    });
});

$(document).on('ready page:load', function() {
  return CountryStateSelect({
    country_id: "country_id",
    state_id: "state_id"
  });
});