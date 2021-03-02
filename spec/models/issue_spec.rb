require 'rails_helper'

RSpec.describe Issue, type: :model do
  let(:issue) { Issue.new }
  let(:title_errors) { issue.errors[:title] }
  let(:priority_errors) { issue.errors[:priority] }
  let(:priority_invalid_error) { "is not included in the list" }
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
        expect(priority_errors).to include(priority_invalid_error)
      end
    end
  end
end
