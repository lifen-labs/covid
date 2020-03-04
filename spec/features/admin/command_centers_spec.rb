require 'rails_helper'

RSpec.describe 'command_centers', type: :feature do
  let(:admin_user)         { create :admin_user }
  let!(:command_center)    { create :command_center }

  before(:each) do
    admin_sign_in_with(admin_user)
  end

  it 'index' do
    visit admin_command_centers_path
  end

  it 'show' do
    visit admin_command_center_path(command_center)
  end
end
