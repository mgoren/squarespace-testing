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
        fill_in 'Field12', with: "Test-#{location}-#{index+1}"
        find('#Field1319_3').set(true)
        fill_in 'Field1319_other', with: 'test pronouns'
        fill_in 'Field13', with: "automated-test-#{location.downcase}-#{index+1}@example.com"
        fill_in 'Field14', with: '123-456-7890'
        select location, from: "Field254"
        select track, from: location_fields[location]
        fill_in 'Field261', with: 'test reason'
        find('#Field774_0').set(true)
        find('#Field775_0').set(true)
        find('#Field877_0').set(true)
        find('#Field1083_0').set(true)
        click_button 'Apply!'
      end
      sleep 5
      expect(page).to have_content 'Thanks for applying!'
    end
  end
end
