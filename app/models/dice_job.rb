class DiceJob
  include HTTParty
  default_options.update(verify: false) # Turn off SSL verification

  base_uri "http://service.dice.com/api/rest/jobsearch/v1/simple.json"

  default_params country: "US"
  format :json

  def self.for term
    get("", query: { text: term})['resultItemList']
  end
end
