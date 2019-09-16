class CsvUploadsController < ApplicationController

  def index
    @csv_uploads = CsvUpload.all.order(created_at: :desc)
  end

  def new
    @csv_upload = CsvUpload.new
  end

  def create
    @csv_upload = CsvUpload.new(csv_upload_params)
    if @csv_upload.save
      flash[:notice] = 'Your upload was successful and being processed'
      redirect_to csv_uploads_path
    else
      render :new
    end
  end
  
  def delete_all
    CsvUpload.destroy_all
    redirect_to new_csv_upload_path
  end

  private

    def csv_upload_params
      params.require(:csv_upload).permit(:csv, :identifier)
    end
end
