class Employee

  attr_accessor :id, :full_name, :email, :birthday, :addresses

  def initialize(options_hash)
    @id = options_hash['id']
    @full_name = options_hash['full_name']
    @email = options_hash['email']
    @birthday = options_hash['birthday']
    @addresses = options_hash['addresses']
  end

  def self.find(id)
    employee = Unirest.get("#{ENV['API_URL']}/#{id}").body
    Employee.new(employee)
  end

end