protocol = Rails.env == 'production' ? 'https' : 'http'

RemotePartial.define(
  url: "#{protocol}://www.warwickshire.gov.uk/tpheadersa1",
  name: 'tpheadersa1',
  minimum_life: 6.hours
)

RemotePartial.define(
  url: "#{protocol}://www.warwickshire.gov.uk/tpfootersa",
  name: 'tpfootersa',
  minimum_life: 6.hours
)

RemotePartial.define(
  url: "#{protocol}://www.warwickshire.gov.uk/tpbarsa",
  name: 'tpbarsa',
  minimum_life: 6.hours
)
