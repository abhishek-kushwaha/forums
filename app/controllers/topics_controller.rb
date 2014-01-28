class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
    @post = Post.new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      @topic = Topic.new(:name => params[:topic][:name], :forum_id => params[:topic][:forum_id])
      @post = Post.new(:content => params[:post][:content], :topic_id => Topic.first.id)
      if @post.save
      redirect_to "/forums/#{@topic.forum_id}", :notice => "Successfully created topic."
    else
      render :action => 'new'
    end
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to @topic, :notice  => "Successfully updated topic."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url, :notice => "Successfully destroyed topic."
  end
end
