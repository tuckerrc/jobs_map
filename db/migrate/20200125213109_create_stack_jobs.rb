class CreateStackJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :stack_jobs do |t|
      t.string :md5hash
      t.text :url
      t.text :xml
      t.text :json
      t.text :geo_json

      t.timestamps
    end
  end
end
