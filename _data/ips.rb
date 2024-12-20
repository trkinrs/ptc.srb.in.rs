require 'csv'
require 'net/http'
require 'json'
require 'uri'

API_URL = 'https://nbs.rs/QRcode/api/qr/v1/gen?lang=sr_RS'
csv_file = '_data/monthly_costs.csv'

output_dir = './images'
Dir.mkdir(output_dir) unless Dir.exist?(output_dir)

CSV.foreach(csv_file, headers: true) do |row|
  office_id = row["office_id"]
  # next unless office_id == "1"
  name = "ips-lokal-#{office_id}"
  name = row['name']
  average_cost = row['average_cost']
  svrha_uplate = "Mesecni troskovi za odrzavanje"

  # json_body = {
  #   "K": "PR",
  #   "V": "01",
  #   "C": "1",
  #   "R": "845000000040484987",
  #   "N": "JP EPS BEOGRAD\r\nBALKANSKA 13",
  #   "I": "RSD3596,13",
  #   "P": "MRĐO MAČKATOVIĆ\r\nŽUPSKA 13\r\nBEOGRAD 6",
  #   "SF": "189",
  #   "S": "UPLATA PO RAČUNU ZA EL. ENERGIJU",
  #   "RO": "97163220000111111111000"
  # }
  json_body = {
    "K": "PR",
    "V": "01",
    "C": "1",
    "R": "160000000055536747",
    "N": "Stambena zajednica\r\nTrg republike 1",
    "I": "RSD#{format("%.2f", average_cost.to_f).tr(".", ",")}",
    "P": name[..69],
    "SF": "189",
    "S": svrha_uplate[...34],
    "RO": "00#{office_id}"
  }

  puts json_body
  uri = URI(API_URL)
  response = Net::HTTP.post(uri, json_body.to_json, { 'Content-Type' => 'application/json' })

  if response.is_a?(Net::HTTPSuccess)
    image_path = File.join(output_dir, "#{name}.png")
    File.open(image_path, 'wb') do |file|
      file.write(response.body)
    end
    puts "Saved image for #{name} to #{image_path}"
  else
    puts "Failed to process #{name}. HTTP Status: #{response.code}, Body: #{response.body}"
  end
  sleep 1
end
