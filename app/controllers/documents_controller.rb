class DocumentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @document = Document.new
  end

  def create
    @dog_id = dog.dog_id
    @document = Document.new(document_params)

    if @document.save
      redirect_to document_path(@document)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end


def document_params
  params.require(:document).permit(:title, :content, :category, :photo)
end


end
