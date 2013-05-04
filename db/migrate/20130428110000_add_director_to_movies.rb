class AddDirectorToMovies < ActiveRecord::Migration
  def up
    change_table :movies do |t|
      t.string :director
    end
  end

  def down
    remove_column :movies, :director
  end

# works locally - autograder barfs
#  def change
#    change_table :movies do |t|
#      t.string :director
#    end
#  end
end
