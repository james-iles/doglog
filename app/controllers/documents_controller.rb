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
      copied_count = copy_to_other_dogs(@document)
      notice_message = if copied_count > 0
        "Created and copied to #{copied_count} other #{'dog'.pluralize(copied_count)}"
      else
        'Document created'
      end
      redirect_to @document, notice: notice_message
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

  def copy_to_other_dogs(original_document)
    return 0 unless params[:copy_to_dog_ids].present?

    dog_ids = params[:copy_to_dog_ids]
    # Only allow dogs from same household for security
    valid_dogs = @dog.household.dogs.where(id: dog_ids).where.not(id: @dog.id)

    valid_dogs.each do |dog|
      new_doc = dog.documents.create(
        title: original_document.title,
        content: original_document.content,
        category: original_document.category
      )
      # Copy photos by attaching the same blobs (efficient, no duplicate storage)
      original_document.photos.each do |photo|
        new_doc.photos.attach(photo.blob)
      end
    end

    valid_dogs.count
  end
end
