class AddImageToNayamis < ActiveRecord::Migration[6.1]
  def change
    add_column :nayamis, :image, :string
  end
end
