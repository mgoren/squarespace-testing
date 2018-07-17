require 'rails_helper'

feature 'leads created when application filled out' do
  let(:close_io_client) { Closeio::Client.new(ENV['CLOSE_IO_API_KEY'], false) }
  let(:phone) { '+11234567890' }
  let(:email) { 'example.com' }
  let(:fields) {
    {
      'status_label': 'Applicant - Potential',
      'custom.lcf_ZD6EzawTf851IK6BqkKi9PugNKthpgjJotbNc9hMSAu': 'Yes',
      'custom.lcf_4qKJ9VGRB1DYjwFSOnrDBowHD4rxBT6KmS82HqU9uoQ': 'Yes',
      'custom.lcf_A6Wt06IbJVBIWiqgOKWveZjWmd1SJNrExmA6mFse0qT': 'Yes',
      'custom.lcf_Ao2W8RL1PK6Q7ofjizg13tUmCsUWW5byZjXffliA8Af': 'test pronouns',
      'custom.lcf_0aPv5aV0sBgfwzMLNUR6zkbWvY2Fq9AKN3nDKxUt5Ru': 'Word of mouth'
    }
  }

  scenario '/apply' do
    CURRENT_TRACKS.each_with_index do |current_track, index|
      location = current_track.split[1]
      contact_name = "Automated Test"
      gclid = "test_gclid_#{index+1}"
      sqf_source = "test_sqf_source_#{index+1}"
      email = "automated-test-#{location.downcase}-#{index+1}@example.com"
      lead = close_io_client.list_leads('email:' + email)['data'].first
      expect(lead['contacts'].first['name']).to eq contact_name
      expect(lead['contacts'].first['emails'].first['email']).to eq email
      expect(lead['contacts'].first['phones'].first['phone']).to eq phone
      fields.keys.each do |key|
        expect(lead[key.to_s]).to eq fields[key]
      end
      if current_track.include?('Part-time')
        expect(lead['custom.lcf_iInuJajOx6zKuSR28JjSaSEJPc7iU2oQ2EqgsNkzGlR']).to eq get_applied(current_track)
      else
        expect(lead['custom.lcf_GrOe1vSEWCpdfHpOaCiEchiYTzlGzg7HpL4rICb2bJh']).to eq get_applied(current_track)
      end
      expect(lead['custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST']).to eq gclid
      expect(lead['custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc']).to eq sqf_source
      puts "PASSED /apply: #{current_track} (#{index+1})"
      close_io_client.delete_lead(lead['id'])
    end
  end

  def get_applied(current_track)
    components = current_track.split
    track = components[7]
    track = 'Part-time' if track == 'Part-time,'
    track = 'Front End Development' if track == 'Front'
    office = components[1].upcase.slice(0,3)
    office = 'PDX' if office == 'POR'
    office = 'WEB' if office == 'ONL'
    track = 'Online' if office == 'WEB'
    year = components[0]
    start_month = components[2].slice(0,3)
    start_day = components[3]
    end_month = components[5].slice(0,3)
    end_day = components[6].chomp(':')
    start = year + '-' + ('0' + Date::ABBR_MONTHNAMES.find_index(start_month).to_s).split(//).last(2).join
    applied = "#{start} #{office} #{track} (#{start_month} #{start_day} - #{end_month} #{end_day})"
    applied = 'PT: ' + applied if track == 'Part-time' || track == 'Online'
    applied
  end
end
