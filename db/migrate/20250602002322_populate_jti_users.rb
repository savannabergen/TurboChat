class PopulateJtiUsers < ActiveRecord::Migration[7.2]
  def up
    User.all.each do |user|
      user.update(jti: SecureRandom.uuid)
    end
  end

  def down
    # No need to do anything here
  end
end
