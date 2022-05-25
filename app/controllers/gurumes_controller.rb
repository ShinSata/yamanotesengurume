class GurumesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    def top
      @rank_gurumes = Gurume.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
    end

    def index
      if params[:search] == nil
          @gurumes= Gurume.all.page(params[:page]).per(3)
      elsif params[:search] == ''
          @gurumes= Gurume.all.page(params[:page]).per(3)
      else
          #部分検索かつ複数検索
          search = params[:search]
          @gurumes = Gurume.where("eatry_name LIKE ? OR genre LIKE ? OR purpose LIKE ? OR price LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").page(params[:page]).per(3)
      end
      @rank_gurumes = Gurume.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
  end

    
      def new
        @gurume = Gurume.new
      end
    
      def create
        gurume = Gurume.new(gurume_params)
        gurume.user_id = current_user.id
        if gurume.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end
      def show
        @gurume = Gurume.find(params[:id])
        @comments = @gurume.comments
        @comment = Comment.new
      end
      def edit
        @gurume = Gurume.find(params[:id])
      end

      def update
        gurume = Gurume.find(params[:id])
        if gurume.update(gurume_params)
          redirect_to :action => "show", :id => gurume.id
        else
          redirect_to :action => "new"
        end
      end
      def destroy
        gurume = Gurume.find(params[:id])
        gurume.destroy
        redirect_to action: :index
      end

    private
  def gurume_params
    params.require(:gurume).permit(:eatry_name, :genre, :adress, :purpose, :price, :delicious, :access, :others, :image, :star,)
  end
end
