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

  def self.all
    employees = []
    api_employees = Unirest.get("#{ENV['API_URL']}", headers: {"Authorization" => "Token token=#{ENV['API_KEY']}", "X-User-Email" => "#{ENV['API_EMAIL']}"}).body
    api_employees.each do |api_employee|
      employees << Employee.new(api_employee)
    end
    employees
  end

  def self.create(first_name, last_name, email)
    employee = Unirest.post("#{ENV['API_URL']}", headers: {"Accept" => "application/json"}, parameters: {first_name: first_name, last_name: last_name, email: email}).body
    Employee.new(employee)
  end

  def destroy
    Unirest.delete("#{ENV['API_URL']}/#{id}")
  end

end