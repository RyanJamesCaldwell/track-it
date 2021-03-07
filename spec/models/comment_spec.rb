require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  let(:comment_content_errors) { comment.errors[:content] }
  let(:presence_error_message) { "can't be blank" }

  describe '#content' do
    context 'presence validation' do
      it 'should reject blank content' do
        comment.content = ''
        comment.validate

        expect(comment_content_errors).to_not be_empty
        expect(comment_content_errors).to include(presence_error_message)
      end
    end
  end
end
