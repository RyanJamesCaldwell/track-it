require 'rails_helper'

RSpec.describe 'Projects', :type => :request do
  describe 'GET projects#index' do
    it 'returns http success' do
      get projects_path
      expect(response).to be_successful
      expect(response.body).to include('Projects')
    end
  end

  describe 'GET projects#new' do
    it 'renders the expected template' do
      get '/projects/new'
      expect(response.body).to include('New Project')
      expect(response).to be_successful
    end
  end

  describe 'POST projects#create' do
    context 'when provided valid project input' do
      it 'creates a new project' do
        example_project_name = 'Example Project Name'
        params = { project: { name: example_project_name, description: 'example description' } }
        post '/projects', params: params
        expect(flash[:success]).to eq("Project '#{example_project_name}' successfully created.")
      end
    end
    context 'when provided invalid project input' do
      it 'to not create a new project and redirect to #new' do
        too_short_project_name = 'A'
        params = { project: { name: too_short_project_name, description: 'example description' } }
        post '/projects', params: params
        expect(flash).to be_empty
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH projects#update' do
    context 'when provided valid project input' do
      let(:project) { create(:project) }

      it 'should update the project' do
        params = { project: { name: 'New Project Name' } }

        patch project_path(project), params: params
        project.reload
        expect(flash[:success]).to eq("Project '#{project.name}' updated.")
        expect(project.name).to eq('New Project Name')
      end
    end
    context 'when provided invalid project input' do
      let(:project) { create(:project) }

      it 'should not update the project' do
        params = { project: { name: 'a' } }

        patch project_path(project), params: params
        project.reload
        expect(flash[:danger]).to eq("Project could not be updated.")
        expect(project.name).to_not eq('a')
      end
    end
  end

  describe 'GET projects#show' do
    let(:example_project) { create(:project) }
    it 'returns http success' do
      get projects_path(example_project)
      expect(response).to be_successful
      expect(response.body).to include(example_project.name)
    end
  end

  describe 'DELETE projects#destroy' do
    context 'when the project is found' do
      let(:example_project) { create(:project) }
      it 'destroys the project' do
        delete project_path(example_project), params: { project: { id: example_project.id } }
        expect(flash[:success]).to eq("Project '#{example_project.name}' deleted.")
      end
    end

    context 'when the project is not found' do
      let(:example_project) { create(:project) }
      it 'does not destroy the project' do
        delete '/projects/1231223'
        expect(flash).to be_empty
      end
    end
  end
end
