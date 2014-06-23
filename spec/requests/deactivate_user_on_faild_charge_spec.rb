require 'spec_helper'

describe 'Deactivate user on failed charge' do
  let(:event_data) do
    {
      "id"=> "evt_104H0Z4GdL7XcZUqzFGQsZBR",
      "created"=> 1403511100,
      "livemode"=> false,
      "type"=> "charge.failed",
      "data"=> {
        "object"=> {
          "id"=> "ch_104H0Z4GdL7XcZUqH4ZjNWg2",
          "object"=> "charge",
          "created"=> 1403511100,
          "livemode"=> false,
          "paid"=> false,
          "amount"=> 999,
          "currency"=> "usd",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_104H0Y4GdL7XcZUq67lhGNUZ",
            "object"=> "card",
            "last4"=> "0341",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 6,
            "exp_year"=> 2015,
            "fingerprint"=> "GGIBNuXYKpCg9hhE",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil,
            "customer"=> "cus_4FhO1x8exZVlt4",
            "type"=> "Visa"
          },
          "captured"=> false,
          "refunds"=> [],
          "balance_transaction"=> nil,
          "failure_message"=> "Your card was declined.",
          "failure_code"=> "card_declined",
          "amount_refunded"=> 0,
          "customer"=> "cus_4FhO1x8exZVlt4",
          "invoice"=> nil,
          "description"=> "payment to fail",
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> nil,
          "receipt_email"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_4H0Zt1CMSqV5Qj"
  }
  end

  it "deactivate a user with the web hook data from stripe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4FhO1x8exZVlt4")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end