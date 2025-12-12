class DocumentsController < ApplicationController
  def index
    @dog = Dog.find(params[:dog_id])
    @documents = @dog.documents.order(created_at: :desc)
  end

  def show
    @document = Document.find(params[:id])
    @dog = @document.dog
  end

  def new
  @dog = Dog.find(params[:dog_id])
  @document = @dog.documents.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @document = @dog.documents.new(document_params)

    if @document.save
      redirect_to @document, notice: 'Document created successfully'
    else
      render :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    @dog = @document.dog
  end

  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    redirect_to document_path(@document)
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to dog_documents_path(@document.dog), notice: "Document deleted"
  end
private
  def document_params
    params.require(:document).permit(:title, :content, :category, photos:[])
  end
end
