class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer :user_id
      t.string :balanced_href

      t.timestamps
    end
  end
end
