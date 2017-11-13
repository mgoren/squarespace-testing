require 'rails_helper'

describe 'form filling' do
  it 'fills out /apply-now form', js: true do
    visit "https://www.epicodus.com/apply-now/?gclid=test_gclid_1&sqf_source=test_sqf_source_1"
    sleep 5
    page.within_frame('wufooFormz12e0pp21gzvlw1') do
      fill_in 'Field11', with: 'Automated'
      fill_in 'Field12', with: 'Apply-Now'
      fill_in 'Field1312', with: 'test pronouns'
      fill_in 'Field13', with: 'automated-apply-now@example.com'
      fill_in 'Field14', with: '123-456-7890'
      select 'Portland', from: "Field254"
      select CURRENT_TRACKS.first, from: "Field256"
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

  it 'fills out /apply form for each track', js: true do
    CURRENT_TRACKS.each_with_index do |track, index|
      location = track.split[1]
      field = location == "Portland" ? 'Field256' : 'Field258'
      visit "https://www.epicodus.com/become-a-programmer-with-epicodus/?gclid=test_gclid_#{index+1}&sqf_source=test_sqf_source_#{index+1}"
      visit "https://www.epicodus.com/apply"
      sleep 5
      page.within_frame('wufooFormz12e0pp21gzvlw1') do
        fill_in 'Field11', with: 'Automated'
        fill_in 'Field12', with: "Test-#{location}-#{index+1}"
        fill_in 'Field1312', with: 'test pronouns'
        fill_in 'Field13', with: "automated-test-#{location.downcase}-#{index+1}@example.com"
        fill_in 'Field14', with: '123-456-7890'
        select location, from: "Field254"
        select track, from: field
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
