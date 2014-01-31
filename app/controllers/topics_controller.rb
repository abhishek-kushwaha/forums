class TopicsController < ApplicationController
  
  def show
    @topic = Topic.find(params[:id])
    @posts = Post.find(:all)
  end

  def new
    @topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)
    @post = Post.new
  end

  def create
    params[:topic][:last_poster_id] = current_user.id
    params[:topic][:last_post_at] = Time.now
    params[:topic][:user_id] = current_user.id
    @topic = Topic.new(params[:topic])
    if @topic.save
      @topic = Topic.new(:name => params[:topic][:name], :last_poster_id => params[:topic][:last_poster_id], :last_post_at => params[:topic][:last_post_at], :forum_id => params[:topic][:forum_id], :user_id => params[:topic][:user_id])
      @post = Post.new(:content => params[:post][:content], :topic_id => Topic.first.id, :user_id => current_user.id)
      if @post.save
      redirect_to "/forums/#{@topic.forum_id}", :notice => "Successfully created topic."
    else
      render :action => 'new'
    end
    else
      render :action => 'new'
    end
  end

  
  def destroy
    @topic = Topic.find(params[:id])
    @post = Post.find(params[:id])
    @topic.destroy
    redirect_to "/forums/#{@topic.forum_id}", :notice => "Successfully deleted topic."
  end
end
