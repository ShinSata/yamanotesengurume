class BookmarksController < ApplicationController
    def create
        bookmark = current_user.bookmarks.create(gurume_id: params[:gurume_id]) #user_idとgurume_idの二つを代入
        redirect_back(fallback_location: root_path)
    end

    def destroy
        bookmark = Bookmark.find_by(gurume_id: params[:gurume_id], user_id: current_user.id)
        bookmark.destroy
        redirect_back(fallback_location: root_path)
    end
end
