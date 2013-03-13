class AddEncryptedToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :encrypted, :boolean, :default => false
  end
end
