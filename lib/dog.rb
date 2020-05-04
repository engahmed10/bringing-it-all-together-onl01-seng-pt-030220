require 'pry'
class Dog

attr_accessor :id,:name,:breed

def initialize(id:nil,name:,breed:)
  @id,@name,@breed=id,name,breed
end

def self.create_table

  DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  DB[:conn].execute("CREATE TABLE IF NOT EXISTS dogs (id INTEGER PRIMARY KEY,name TEXT,breed TEXT)")

end

def self.drop_table
  DB[:conn].execute("DROP TABLE IF EXISTS dogs")
end

def save

  if self.id
     self.update
  else
     sql=<<-SQL
       INSERT INTO dogs (name,breed) VALUES (?,?)
     SQL
     DB[:conn].execute(sql,self.name,self.breed)
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  end
  return self

end

def self.create(hash_attr)
  #binding.pry
  new=self.new(hash_attr[breed],hash_attr[name])
  binding.pry

  new.save
  new
end

def update
  DB[:conn].execute("UPDATE dogs SET name = ?,breed = ? WHERE id=?",self.name,self.breed,self.id)
end

def self.new_from_db
    data=DB[:conn].execute("SELECT * FROM dogs")
end

end
