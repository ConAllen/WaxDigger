# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#the below code is for stripe validation. Once i enter vallid stripe test creditcard details "4242424242424242" which are available
#on their site. and enter it into buy a product. The code below varifys it and stripe sends me a token number.
# Once you see the token alert which appears after you enter a valid test number. you get an alert with a stripe token
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  record.setupForm()

record =
  setupForm: ->
    $('#new_record').submit ->
      $('input[type=submit]').attr('disabled', true)
      Stripe.bankAccount.createToken($('#new_record'), record.handleStripeResponse)
      false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_record').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_record')[0].submit()
      alert(response.id)
    else
      $('#stripe_error').text(response.error.message).show()
