class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :priority
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
