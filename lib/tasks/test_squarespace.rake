desc "Test Squarespace"
task :test_squarespace => [:environment] do

  phone = '+1234567890'
  email = 'example.com'
  address = { 'address_1': 'test address', 'city': 'Portland', 'state': 'OR', 'zipcode': '12345', 'country': 'US' }
  fields = {
    'custom.lcf_ZD6EzawTf851IK6BqkKi9PugNKthpgjJotbNc9hMSAu': 'I have a high school diploma or equivalent.',
    'custom.lcf_4qKJ9VGRB1DYjwFSOnrDBowHD4rxBT6KmS82HqU9uoQ': 'I am 18 or older.',
    'custom.lcf_A6Wt06IbJVBIWiqgOKWveZjWmd1SJNrExmA6mFse0qT': 'I am authorized to work in the United States.',
    'custom.lcf_Ao2W8RL1PK6Q7ofjizg13tUmCsUWW5byZjXffliA8Af': 'test pronouns',
    'custom.lcf_0aPv5aV0sBgfwzMLNUR6zkbWvY2Fq9AKN3nDKxUt5Ru': 'Word of mouth',
  }
  applicants = [
    {
      'contact_name': 'Automated Test-Portland-1',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Portland September 5 - March 23: C#/.NET track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'C#/.NET',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Portland',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_1',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_1'
      }
    },
    {
      'contact_name': 'Automated Test-Portland-2',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Portland September 5 - March 23: CSS/Design track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'CSS/Design',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Portland',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_2',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_2'
      }
    },
    {
      'contact_name': 'Automated Test-Portland-3',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Portland September 6 - December 13: Part-time, evening Intro to Programming',
        # 'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': '',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Portland',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_3',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_3'
      }
    },
    {
      'contact_name': 'Automated Test-Portland-4',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Portland October 9 - April 27: CSS/React track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'CSS/React',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Portland',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_4',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_4'
      }
    },
    {
      'contact_name': 'Automated Test-Portland-5',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Portland November 13 - June 1: Java/Android track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'Java/Android',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Portland',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_5',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_5'
      }
    },
    {
      'contact_name': 'Automated Test-Seattle-1',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Seattle September 5 - March 23: C#/.NET track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'C#/.NET',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Seattle',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_1',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_1'
      }
    },
    {
      'contact_name': 'Automated Test-Seattle-2',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Seattle September 6 - December 13: Part-time, evening Intro to Programming',
        # 'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': '',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Seattle',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_2',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_2'
      }
    },
    {
      'contact_name': 'Automated Test-Seattle-3',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Seattle October 9 - April 27: Ruby/Rails track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'Ruby/Rails',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Seattle',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_3',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_3'
      }
    },
    {
      'contact_name': 'Automated Test-Seattle-4',
      'fields': {
        'status_label': 'Applicant - Potential',
        'custom.lcf_K2JfqWIJDcI40MfvV2IYmFdgXWUWF49kn3u1Ah0URTJ': '2017 Seattle November 13 - June 1: C#/.NET track',
        'custom.lcf_raALxiPv1Pyj0UjzlZooDPM3LzYe7GVBUeCBnFfp1Xi': 'C#/.NET',
        'custom.lcf_cLOVwwxk5KM718I4LJ4zwYpemYH4ULYL1n8qcHrio78': 'Seattle',
        'custom.lcf_evscNi8u9X80uVkSZwQ9UOIZadoeewAVinWIpFIh0ST': 'test_gclid_4',
        'custom.lcf_QwLH5hV1Nzu6Np0tT3GpnBoW4GhXmeOWO7SBJwIxUjc': 'test_sqf_source_4'
      }
    },
  ]

  close_io_client ||= Closeio::Client.new(ENV['CLOSE_IO_API_KEY'], false)

  applicants.each do |applicant|
    name = applicant[:contact_name]
    lead = close_io_client.list_leads('contact_name': name)[:data].first
    puts "Unmatched email: #{name}" unless lead[:contacts].first[:emails].first[:email].split('@').last == email
    puts "Unmatched phone: #{name}" unless lead[:contacts].first[:phones].first[:phone] == phone
    address.keys.each do |key|
      puts "Unmatched address: #{name}" unless lead[:addresses].first[key] == address[key]
    end
    fields.keys.each do |key|
      puts "Unmatched field #{key.to_s}: #{name}" unless lead[key] == fields[key]
    end
    applicant[:fields].keys.each do |key|
      puts "Unmatched field #{key.to_s}: #{name}" unless lead[key] == applicant[:fields][key]
    end
  end

end
