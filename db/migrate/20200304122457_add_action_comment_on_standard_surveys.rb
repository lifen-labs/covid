class AddActionCommentOnStandardSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_surveys, :action_comment, :text
  end
end
