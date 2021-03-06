require 'rails_helper'

describe 'form filling' do
  it 'fills out /apply form for each track', js: true do
    CURRENT_TRACKS.each_with_index do |track, index|
      location = track.split[3]
      location = 'Portland' if location == 'PDX'
      location = 'Seattle' if location == 'SEA'
      location = 'Online' if location == 'WEB'
      location_fields = { 'Portland' => 'Field256', 'Seattle' => 'Field258', 'Online' => 'Field1323' }
      visit "https://www.epicodus.com/?gclid=test_gclid_#{index+1}&sqf_source=test_sqf_source_#{index+1}"
      visit "https://www.epicodus.com/sign-up"
      sleep 5
      page.within_frame('wufooFormz12e0pp21gzvlw1') do
        fill_in 'Field11', with: 'Manual'
        fill_in 'Field12', with: "Test-#{location}-#{index+1}"
        fill_in 'Field13', with: "manual-test-#{location.downcase}-#{index+1}@mortalwombat.net"
        fill_in 'Field14', with: "#{index}#{index}#{index}-#{index+1}#{index+1}#{index+1}-#{index+2}#{index+2}#{index+2}#{index+2}"
        select location, from: "Field254"
        select track, from: location_fields[location]
        find('#Field774_0').set(true) # over 18
        sleep 1
        find('#Field775_0').set(true) # diploma
        sleep 1
        find('#Field877_0').set(true) # work eligibility (usa)
        sleep 1
        find('#Field1321_0').set(true) # work elibility (job search country)
        sleep 1
        find('#Field1083_0').set(true) # heard about epicodus
        sleep 1
        click_button 'Sign up!'
      end
      sleep 5
      expect(page).to have_content 'Thanks for signing up!'
    end
  end
end
