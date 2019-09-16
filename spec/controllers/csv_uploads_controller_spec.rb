require 'rails_helper'

RSpec.describe CsvUploadsController, type: :controller do
  describe "GET index" do
    it "assigns @csv_uploads" do
      csv_upload = create(:csv_upload)
      get :index
      expect(assigns(:csv_uploads)).to eq([csv_upload])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      assigns(:csv_upload).should be_kind_of(CsvUpload)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a new csv upload" do
      csv_uploads_params = build(:csv_upload).attributes.merge(csv: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/test_csv.csv'))))
      expect { post :create, params: { csv_upload: csv_uploads_params } }.to change(CsvUpload, :count).by(1)
    end
  end
end
