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
          @gurumes = Gurume.where("eatry_name LIKE ? OR genre LIKE ? OR purpose LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%").page(params[:page]).per(3)
      end
      @rank_gurumes = Gurume.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
      @tag_list = Tag.all
    end
    def search
      @tag_list = Tag.all               # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
      @tag = Tag.find(params[:tag_id])  # クリックしたタグを取得
      @gurumes = @tag.gurumes.all           # クリックしたタグに紐付けられた投稿を全て表示
  end
    
      def new
        @gurume = Gurume.new
        @gurume = current_user.gurumes.new
      end
    
      def create
        gurume = Gurume.new(gurume_params)
        gurume.user_id = current_user.id
        tag_list = params[:gurume][:tag_name].split(nil)
        if gurume.save
          gurume.save_tag(tag_list)
          params[:gurume][:images]&.each do |image|
            Image.create!(image: image, gurume_id: gurume.id)
          end
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end
      def show
        @gurume = Gurume.find(params[:id])
        @comments = @gurume.comments
        @comment = Comment.new
        @gurume_tags = @gurume.tags
      end
      def edit
        @gurume = Gurume.find(params[:id])
        @tag_list = @gurume.tags.pluck(:tag_name).join(nil)
      end

      def update
        gurume = Gurume.find(params[:id])
        tag_list = params[:gurume][:tag_name].split(nil)
        if gurume.update(gurume_params)
          params[:gurume][:images]&.each do |image|
            Image.create!(image: image, gurume_id: gurume.id)
          end
          # このgurume_idに紐づいていたタグを@oldに入れる
          old_relations = TagMap.where(gurume_id: gurume.id)
          # それらを取り出し、消す。
          old_relations.each do |relation|
            relation.delete
          end
    
          gurume.save_tag(tag_list)
          redirect_to :action => "show", :id => gurume.id
        else
          redirect_to :action => "edit"
        end
      end
      def destroy
        gurume = Gurume.find(params[:id])
        gurume.destroy
        redirect_to action: :index
      end

    private
  def gurume_params
    params.require(:gurume).permit(:eatry_name, :genre, :adress, :purpose, :price, :delicious, :access, :others, :star, :images)
  end
end
