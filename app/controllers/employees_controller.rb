class EmployeesController < ApplicationController
  def index
    # @employees = Employee.all
    @employees = Unirest.get("http://localhost:3000/api/v2/employees").body #array
  end

  def show
    # @employee = Employee.find_by(id: params[:id])
    @employee = Unirest.get("http://localhost:3000/api/v2/employees/#{params[:id]}").body #hash
  end

  def new
    
  end

  def create
    # @employee = Employee.create(first_name:)
    @employee = Unirest.post("http://localhost:3000/api/v2/employees", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name], email: params[:email]}).body
    redirect_to "/employees/#{@employee['id']}"
  end
end
