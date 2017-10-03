class EmployeesController < ApplicationController
  def index
    # @employees = Employee.all
    @employees = []
    api_employees = Unirest.get("#{ENV['API_URL']}").body #array
    api_employees.each do |api_employee|
      @employees << Employee.new(api_employee)
    end

  end

  def show
    # @employee = Employee.find_by(id: params[:id])
    @employee = Employee.new(Unirest.get("#{ENV['API_URL']}/#{params[:id]}").body) #hash
  end

  def new
    
  end

  def create
    # @employee = Employee.create(first_name:)
    @employee = Unirest.post("#{ENV['API_URL']}", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name], email: params[:email]}).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def edit
    @employee = Unirest.get("#{ENV['API_URL']}/#{params[:id]}").body
  end

  def update
    @employee = Unirest.get("#{ENV['API_URL']}/#{params[:id]}").body
    Unirest.patch("#{ENV['API_URL']}/#{@employee['id']}", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name], email: params[:email]}).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    Unirest.delete("#{ENV['API_URL']}/#{params[:id]}")
    redirect_to '/employees'
  end
end
