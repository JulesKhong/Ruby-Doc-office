require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('homepage loading',{ :type => :feature}) do
  it("shows the homepage when the site loads") do
    visit('/')
    expect(page).to have_content('Wellness')
  end
end

describe('adding a doctor',{ :type => :feature}) do
  it("allows an admin to add a doctor and their specialty to the site") do
    visit('/')
    fill_in('doctor', :with => "Dr. Who")
    fill_in('specialty', :with => "time travel")
    click_button('Add Doctor')
    expect(page).to have_content("Dr. Who has been added")
  end
end


describe('assigning a doctor to a patient',{ :type => :feature }) do
  it("allows an admin to assign a doctor to a patient") do
    visit('/')
    fill_in('doctor', :with => "Dr. Who")
    fill_in('specialty', :with => "time travel")
    click_button('Add Doctor')
    click_link('Return to dashboard')
    expect(page).to have_content('Dr. Who')
  end
end

describe('adding a patient',{ :type => :feature}) do
  it("allows an admin to add a patient and their birthday to the site") do
    visit('/')
    fill_in('doctor', :with => "Dr. Who")
    fill_in('specialty', :with => "time travel")
    click_button('Add Doctor')
    click_link('Return to dashboard')
    fill_in('name', :with => 'Doug')
    fill_in('birthday', :with => '1902-07-04')
    select('Dr. Who', :from => 'doctors')
    click_button('Add Patient')
    expect(page).to have_content('Doug has been added')
  end
end
