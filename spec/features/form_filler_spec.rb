require 'rails_helper'

describe 'form filling' do
  it 'fills out /apply form for each track', js: true do
    CURRENT_TRACKS.each_with_index do |track, index|
      location = track.split[1]
      location_fields = { 'Portland' => 'Field256', 'Seattle' => 'Field258', 'Online' => 'Field1314' }
      visit "https://www.epicodus.com/?gclid=test_gclid_#{index+1}&sqf_source=test_sqf_source_#{index+1}"
      visit "https://www.epicodus.com/apply"
      sleep 5
      page.within_frame('wufooFormz12e0pp21gzvlw1') do
        fill_in 'Field11', with: 'Automated'
        fill_in 'Field12', with: "Test"
        fill_in 'Field13', with: "automated-test-#{location.downcase}-#{index+1}@example.com"
        fill_in 'Field14', with: '123-456-7890'
        select location, from: "Field254"
        select track, from: location_fields[location]
        find('#Field774_0').set(true) # over 18
        find('#Field775_0').set(true) # diploma
        find('#Field877_0').set(true) # work eligibility (usa)
        find('#Field1321_0').set(true) # work elibility (job search country)
        find('#Field1083_0').set(true) # heard about epicodus
        click_button 'Sign up!'
      end
      sleep 5
      expect(page).to have_content 'Thanks for signing up!'
    end
  end
end
