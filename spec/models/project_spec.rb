require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { Project.new }
  let(:project_errors) { project.errors[:name] }
  let(:presence_error_message) { "can't be blank" }
  let(:uniqueness_error_message) { "has already been taken" }
  let(:name_too_short_message) { "is too short (minimum is 3 characters)" }
  let(:name_too_long_message) { "is too long (maximum is 30 characters)" }

  describe '#name' do
    context 'presence validation' do
      it 'should reject nil names' do
        project.name = nil
        project.validate
        
        expect(project_errors).to_not be_empty
        expect(project_errors).to include(presence_error_message)
      end

      it 'should reject blank names' do
        project.name = ''
        project.validate
  
        expect(project_errors).to_not be_empty
        expect(project_errors).to include(presence_error_message)
      end
    end

    context 'uniqueness validation' do
      let(:conflicting_name) { 'Example Project Name' }

      it 'should not allow duplicate names' do
        Project.create(name: conflicting_name)
        project.name = conflicting_name
        project.validate
  
        expect(project_errors).to_not be_empty
        expect(project_errors).to include(uniqueness_error_message)
      end
    end

    context 'length validation' do
      it 'should reject names less than 3 characters' do
        project.name = 'Q1'
        project.validate

        expect(project_errors).to_not be_empty
        expect(project_errors).to include(name_too_short_message)
      end

      it 'should reject names greater than 30 characters' do
        project.name = FFaker::Lorem.characters(31)
        project.validate

        expect(project_errors).to_not be_empty
        expect(project_errors).to include(name_too_long_message)
      end
    end
  end
end
