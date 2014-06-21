require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
    {
      "id"=> "evt_104Fal4GdL7XcZUqwuLn2r4T",
      "created"=> 1403184463,
      "livemode"=> false,
      "type"=> "charge.succeeded",
      "data"=> {
        "object"=> {
          "id"=> "ch_104Fal4GdL7XcZUqJ6nQfKLh",
          "object"=> "charge",
          "created"=> 1403184463,
          "livemode"=> false,
          "paid"=> true,
          "amount"=> 999,
          "currency"=> "usd",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_104Fal4GdL7XcZUqqFuT4wYa",
            "object"=> "card",
            "last4"=> "4242",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 6,
            "exp_year"=> 2018,
            "fingerprint"=> "glLDFj1zApoBE82z",
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
            "customer"=> "cus_4FalIs6jcH3qFw",
            "type"=> "Visa"
          },
          "captured"=> true,
          "refunds"=> [],
          "balance_transaction"=> "txn_104Fal4GdL7XcZUqbeKXpBAQ",
          "failure_message"=> nil,
          "failure_code"=> nil,
          "amount_refunded"=> 0,
          "customer"=> "cus_4FalIs6jcH3qFw",
          "invoice"=> "in_104Fal4GdL7XcZUqDwgkbrh4",
          "description"=> nil,
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> nil,
          "receipt_email"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_4Fale0NTlWvb8V"
    }
  end

  it "create a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "create the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4FalIs6jcH3qFw")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4FalIs6jcH3qFw")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4FalIs6jcH3qFw")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_104Fal4GdL7XcZUqJ6nQfKLh")
  end
end