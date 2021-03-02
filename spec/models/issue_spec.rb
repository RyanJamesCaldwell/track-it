require 'rails_helper'

RSpec.describe Issue, type: :model do
  let(:issue) { create(:issue) }
  let(:title_errors) { issue.errors[:title] }
  let(:priority_errors) { issue.errors[:priority] }
  let(:category_errors) { issue.errors[:category] }
  let(:state_errors) { issue.errors[:state] }
  let(:inclusion_error) { "is not included in the list" }
  let(:title_too_short_error) { "is too short (minimum is 5 characters)" }
  let(:title_too_long_error) { "is too long (maximum is 50 characters)" }
  let(:blank_title_error) { "can't be blank" }

  describe '#title' do
    context 'presence validation' do
      it 'should reject nil titles' do
        issue.title = nil
        issue.validate

        expect(title_errors).to_not be_empty
        expect(title_errors).to include(blank_title_error)
      end
      it 'should reject blank titles' do
        issue.title = ''
        issue.validate

        expect(title_errors).to_not be_empty
        expect(title_errors).to include(blank_title_error)
      end
    end

    context 'length requirements' do
      it 'should reject titles less than 5 characters' do
        issue.title = 'abc'
        issue.validate

        expect(title_errors).to_not be_empty
        expect(title_errors).to include(title_too_short_error)
      end

      it 'should reject titles longer than 50 characters' do
        issue.title = FFaker::Lorem.characters(51)
        issue.validate

        expect(title_errors).to_not be_empty
        expect(title_errors).to include(title_too_long_error)
      end
    end
  end

  describe '#priority' do
    context 'inclusion validation' do
      it 'should reject priorities that are not recognized' do
        issue.title = 'Example Issue'
        issue.priority = 'Super Important'

        issue.validate
        expect(priority_errors).to_not be_empty
        expect(priority_errors).to include(inclusion_error)
      end
    end
  end

  describe '#category' do
    context 'inclusion validation' do
      it 'should reject categories that are not recognized' do
        issue.title = 'Example Issue'
        issue.category = 'bad category'

        issue.validate
        expect(category_errors).to_not be_empty
        expect(category_errors).to include(inclusion_error)
      end
    end
  end

  describe '#state' do
    context 'inclusion validation' do
      it 'should reject states that are not recognized' do
        issue.state = 'fake state!'

        issue.validate
        expect(state_errors).to_not be_empty
        expect(state_errors).to include(inclusion_error)
      end
    end
  end
end
