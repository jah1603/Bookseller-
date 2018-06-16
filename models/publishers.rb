require_relative('../db/sql-runner')

class Publisher

  attr_reader :name, :id, :address, :city, :region, :country, :country, :postcode, :tel, :email

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @address = options['address']
    @city = options['city']
    @region = options['region']
    @country = options['country']
    @postcode = options['postcode']
    @tel = options['tel']
    @email = options['email']
  end

  def save()
    sql = "INSERT INTO publishers
    (
      name, address, city, region, country, postcode, tel, email
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7, $8
    )
    RETURNING *"
    values = [@name]
    publisher_data = SqlRunner.run(sql, values)
    @id = publisher_data.first()['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM publishers;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM publishers"
    publishers = SqlRunner.run( sql )
    result = publishers.map { |publisher| Publisher.new( publisher ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM publishers WHERE id = $1"
    values = [id]
    publisher = SqlRunner.run( sql, values )
    result = publisher.new( publisher.first )
    return result
  end


end
