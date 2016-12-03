require 'google/apis/sheets_v4'

SHEET_ID = '12MWdBhpYMnBNyRSd_0QFpkRCgkWrjt1cLEFsD1AzWl0'

Google::Apis.logger.level = Logger::DEBUG

scopes =  [
  'https://www.googleapis.com/auth/spreadsheets'
]

service = Google::Apis::SheetsV4::SheetsService.new
service.authorization

row = Google::Apis::SheetsV4::ValueRange.new(
  valueInputOption: 'RAW',
  values: ['a', 'b', 'c', 'd']
)

service.append_spreadsheet_value(SHEET_ID, 'A1:Z9999', [row])
