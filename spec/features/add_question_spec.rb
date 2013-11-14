require 'spec_helper'

describe 'Add Question' do
  let(:user) { create :user }
  let!(:category) { create :category }

  context 'with current user' do
    before :each do
      login_as user
    end

    it 'adds new question', js: true do
      visit root_path

      click_link 'Pridať otázku'

      fill_in 'question_title', with: ''
      fill_in 'question_text',  with: ''

      click_button 'Pridať'

      expect(page).to have_content('Nadpis – je povinná položka')
      expect(page).to have_content('Text – je povinná položka')

      fill_in 'question_title', with: 'Lorem ipsum title?'
      fill_in 'question_text',  with: 'Lorem ipsum'

      select category.name, from: 'question_category_id'

      fill_in_select2 'question_tag_list', with: 'linux server'
      fill_in_select2 'question_tag_list', with: 'elasticsearch'

      click_button 'Pridať'

      expect(page).to have_content('Vaša otázka bola úspešne pridaná.')

      # TODO (smolnar) remove! use content expectations for checking attributes
      # TODO (smolnar) consider checking of existing tag relation
      expect(Question).to have(1).record

      question = Question.first

      expect(question.title).to eql('Lorem ipsum title?')
      expect(question.text).to eql('Lorem ipsum')
      expect(question.category).to eql(category)
      expect(question.tag_list.sort).to eql(['elasticsearch', 'linux-server'])
    end
  end
end