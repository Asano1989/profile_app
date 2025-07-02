class AddColumnPublicUidToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :public_uid, :string
    add_index  :profiles, :public_uid, unique: true
  end
end
