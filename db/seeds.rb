require 'csv'

class Seed

  def initialize
    generate_industries
    generate_categories
    generate_services
    generate_bids_with_conversations
  end

  def generate_bids_with_conversations
    pro = Pro.create(first_name: "Bob", last_name: "Ross", zipcode: "80203", phone_number: "5555555", email: "bross@gmail.com", password: "password")

    pro_service = pro.create_pro_service(service_ids: [1])

    requester = User.create(first_name: "Burt", last_name: "Reynolds", zipcode: "80203", phone_number: "5555554", email: "turdferguson@gmail.com", password: "password")

    project = Project.create(status: "open", zipcode: "80203", recurring: false, description: "Help me.", timeline: "ASAP", requester_id: 2, service_id: 1)

    bid = Bid.create(user_id: 1, project_id: 1, amount: "100", comment: "I can help.", status: "open")
  end

  def generate_industries
    industries.each do |industry|
      new_industry = Industry.create!(name: industry[:name])

      puts "Created #{new_industry.name}"
    end
  end

  def generate_categories
    categories.each do |category|
      new_category = Category.create!(name: category[:name],
                                      industry: Industry.find_by(name: category[:industry_name]))

    puts "Created #{new_category.name}"
    end
  end

  def generate_services
    services.each do |service|
      new_service = Service.create!(name: service[:name],
                      category: Category.find_by(name: service[:category_name]))

      puts "Created #{new_service.name}"
    end
  end

  def industries
    CSV.open'db/csv/industries_services_categories/industries-Table 1.csv', headers: true, header_converters: :symbol
  end

  def categories
    CSV.open'db/csv/industries_services_categories/categories-Table 1.csv', headers: true, header_converters: :symbol
  end

  def services
    CSV.open'db/csv/industries_services_categories/services-Table 1.csv', headers: true, header_converters: :symbol
  end
end

Seed.new
