require 'rails_helper'

describe 'Create Certificate Template' do
  Given(:subject) { page }

  Given { login_as_admin }
  Given { visit new_certificate_template_path }

  describe 'can not create' do
    When { find('input[type="submit"]').click }

    Then { is_expected.to have_selector('form .alert-danger') }
    And  { is_expected.to have_selector('h1.text-center', text: I18n.t('certificate_templates.new.title')) }
  end

  describe 'can create' do
    Given(:new_title) { 'some certificate title' }

    When { fill_in 'certificate_template[title]', with: new_title }
    When { attach_file 'certificate_template[background]', "#{Rails.root}/spec/fixtures/10x10.png" }
    When { find('input[type="submit"]').click }

    Then { is_expected.to have_selector('.alert-notice') }
    And  { is_expected.to have_selector('h1', text: new_title) }
  end
end