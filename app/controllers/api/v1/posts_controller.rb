class Api::V1::PostsController < Api::BaseController
  def index
    respond_with paginate(filtered_collection(Post.all))
  end

  def show
    respond_with Post.find_by!(id: params[:id])
  end

  def create
    new_post = Post.new(post_params)
    new_post.author = author
    
    respond_with new_post.save!
  end

  def update
    post.update!(post_params)
    respond_with post
  end

  def destroy
    respond_with post.destroy!
  end

  private

  def post
    @post ||= Post.find_by!(id: params[:id])
  end

  def author
    @author ||= User.find_by!(id: params[:author][:id])
  end

  def post_params
    params.require(:post).permit(
      :author,
      :title,
      :body
    )
  end
end