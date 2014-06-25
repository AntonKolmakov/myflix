require 'spec_helper'

feature "Admin sees admin box" do
  background do
    alice = Fabricate(:user, full_name: "Alice Wonder", email: "alice@example.com")
    Fabricate(:payment, amount: 999, user: alice)
  end

  scenario "admin can see admin box" do
    sign_in(Fabricate(:admin))
    visit home_path
    expect(page).to have_content("Admin")
  end

  scenario "user can't see admin box" do
    sign_in(Fabricate(:user))
    visit home_path
    expect(page).not_to have_content("Admin")
  end

  scenario "admin can see payments" do
    sign_in(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Alice Wonder")
    expect(page).to have_content("alice@example")
  end

  scenario "user cannot see payments" do
    sign_in(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Alice Wonder")
    expect(page).to have_content("You are not authorized to do that.")
  end
end