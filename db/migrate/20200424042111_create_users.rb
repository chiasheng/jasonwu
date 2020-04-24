class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :apple
      t.string :telegram
      t.string :locale
    end
  end
end
