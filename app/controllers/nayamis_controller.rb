class NayamisController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @nayamis = Nayami.all.order(created_at: :desc)
        if params[:tag_ids]
            @nayamis = []
            params[:tag_ids].each do |key, value|      
              @nayamis += Tag.find_by(name: key).nayamis if value == "1"
            end
            @nayamis.uniq!
        end
        if params[:tag]
            Tag.create(name: params[:tag])
        end
    end
    
    def new
        @nayami = Nayami.new
    end
    
    def create
        nayami = Nayami.new(nayami_params)

        nayami.user_id = current_user.id

        if nayami.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
        @nayami = Nayami.find(params[:id])
        @comments = @nayami.comments
        @comment = Comment.new
    end

    def edit
        @nayami = Nayami.find(params[:id])
    end

    def update
        nayami = Nayami.find(params[:id])
        if nayami.update(nayami_params)
          redirect_to :action => "show", :id => nayami.id
        else
          redirect_to :action => "new"
        end
    end

    def destroy
        nayami = Nayami.find(params[:id])
        nayami.destroy
        redirect_to action: :index
    end

    def explanation
    end
    
    private
    def nayami_params
        params.require(:nayami).permit(:body, :user_id, :image, tag_ids: [])
    end
end
