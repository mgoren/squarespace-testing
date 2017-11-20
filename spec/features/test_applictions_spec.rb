require 'rails_helper'

feature 'leads created when application filled out' do
  let(:close_io_client) { Closeio::Client.new(ENV['CLOSE_IO_API_KEY'], false) }
  let(:phone) { '+1234567890' }
  let(:email) { 'example.com' }
  let(:fields) {
    {
      'status_label': 'Applicant - Potential',
      'custom.lcf_ZD6EzawTf851IK6BqkKi9PugNKthpgjJotbNc9hMSAu': 'I have a high school diploma or equivalent.',
      'custom.lcf_4qKJ9VGRB1DYjwFSOnrDBowHD4rxBT6KmS82HqU9uoQ': 'I am 18 or older.',
      'custom.lcf_A6Wt06IbJVBIWiqgOKWveZjWmd1SJNrExmA6mFse0qT': 'I am authorized to work in the United States.',
      'custom.lcf_Ao2W8RL1PK6Q7ofjizg13tUmCsUWW5byZjXffliA8Af': 'test pronouns',
      'custom.lcf_0aPv5aV0sBgfwzMLNUR6zkbWvY2Fq9AKN3nDKxUt5Ru': 'Word of mouth'
    }
  }

  scenario '/apply' do
    CURRENT_TRACKS.each_with_index do |current_track, index|
      location = current_track.split[1]
      contact_name = "Automated Test-#{location}-#{index+1}"
      gclid = "test_gclid_#{index+1}"
      sqf_source = "test_sqf_source_#{index+1}"
      email = "automated-test-#{location.downcase}-#{index+1}@example.com"
      lead = close_io_client.list_leads('email': email)[:data].first
      expect(lead[:contacts].first[:name]).to eq contact_name
      expect(lead[:contacts].first[:emails].first[:email]).to eq email
      expect(lead[:contacts].first[:phones].first[:phone]).to eq phone
      fields.keys.each do |key|
        expect(lead[key]).to eq fields[key]
      end
      expect(lead['custom.lcf_GrOe1vSEWCpdfHpOaCiEchiYTzlGzg7HpL4rICb2bJh']).to eq get_applied(current_track)
      expect(lead['custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST']).to eq gclid
      expect(lead['custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc']).to eq sqf_source
      puts "PASSED /apply: #{current_track} (#{index+1})"
    end
  end

  scenario '/apply-now' do
    current_track = CURRENT_TRACKS.first
    location = 'Portland'
    contact_name = "Automated Apply-Now"
    gclid = "test_gclid_1"
    sqf_source = "test_sqf_source_1"
    email = "automated-apply-now@example.com"
    lead = close_io_client.list_leads('email': email)[:data].first
    expect(lead[:contacts].first[:name]).to eq contact_name
    expect(lead[:contacts].first[:emails].first[:email]).to eq email
    expect(lead[:contacts].first[:phones].first[:phone]).to eq phone
    fields.keys.each do |key|
      expect(lead[key]).to eq fields[key]
    end
    expect(lead['custom.lcf_GrOe1vSEWCpdfHpOaCiEchiYTzlGzg7HpL4rICb2bJh']).to eq get_applied(current_track)
    expect(lead['custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST']).to eq gclid
    expect(lead['custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc']).to eq sqf_source
    puts "PASSED /apply-now"
  end

  def get_applied(current_track)
    components = current_track.split
    track = components[7]
    track = 'Part-time' if track == 'Part-time,'
    office = components[1].upcase.slice(0,3)
    office = 'PDX' if office == 'POR'
    year = components[0]
    start_month = components[2].slice(0,3)
    start_day = components[3]
    end_month = components[5].slice(0,3)
    end_day = components[6].chomp(':')
    start = year + '-' + ('0' + Date::ABBR_MONTHNAMES.find_index(start_month).to_s).split(//).last(2).join
    applied = "#{start} #{office} #{track} (#{start_month} #{start_day} - #{end_month} #{end_day})"
    applied = 'PT: ' + applied if track == 'Part-time'
    applied
  end
end