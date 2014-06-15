class Payment
  constructor: ->
    $('#payment-form').on 'submit', (event) =>
      form = $(event.currentTarget)
      form.find('button').prop('disabled', true)
      Stripe.card.createToken(form, @stripeResponseHandler)
      return false

  stripeResponseHandler: (status, response) =>
    form = $('#payment-form')
    if response.error
      form.find('.payment-errors').addClass('.alert alert-danger').text(response.error.message)
      form.find('button').prop('disabled', false)
    else
      token = response.id
      form.append($("<input type='hidden' name='stripeToken' />").val(token))
      form.get(0).submit()

$ ->
  new Payment