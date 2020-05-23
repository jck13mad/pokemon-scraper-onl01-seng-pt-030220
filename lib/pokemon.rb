class Pokemon
  
  attr_accessor :name, :type, :id, :db, :hp 
  
  def initialize(id, name, type, hp, db)
    @id = id,
    @name = name,
    @type = type,
    @hp = hp,
    @db = db
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) 
      VALUES (?, ?);
    SQL
    
    db.execute(sql, [name, type])
  end
  
  def self.find(id, database_connection)
    pokemon = database_connection.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    name = pokemon[1]
    type = pokemon[2]
    hp = pokemon[3]

    pokemon_inst = Pokemon.new(id: id, name: name, type: type, hp: hp, db: database_connection)
  end
  
  def alter_hp(new_hp)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL
    
    db.execute(sql, [new_hp, id])
  end
  
  
end
