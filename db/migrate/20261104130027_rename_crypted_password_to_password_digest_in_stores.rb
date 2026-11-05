class RenameCryptedPasswordToPasswordDigestInStores < ActiveRecord::Migration[8.1]
  def change
    rename_column :stores, :crypted_password, :password_digest
  end
end
