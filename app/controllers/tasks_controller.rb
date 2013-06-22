class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy, :motivate]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(:deleted => false, :completed => false).all
    @tasks_done = Task.where(:deleted => false, :completed => true).all
    @task = Task.new
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save

        @task.generate_tags!
        @task.save

        format.html { render :partial => 'task_entry', :locals => {:task => @task} }
        format.json { render json: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)

        # generate tags again
        @task.tags.delete_all
        @task.generate_tags!
        @task.save

        format.html { head :no_content }
        format.json { render json: @task }
      else
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  # GET /tasks/1/motivate
  def motivate
    require 'open-uri'
    require 'json'

    url = 'http://api.giphy.com/v1/gifs/translate?api_key=dc6zaTOxFJmzC&limit=1&s='

    tag = @task.tags.sample

    query = tag.nil? ? '' : tag.name

    content = open(url + URI::encode(query), "UserAgent" => "Ruby-Wget").read
    result = JSON.parse(content)

    gif = result['data']

    # people at giphy decided to make my life hard by removing the random gif
    # when a search query returns no results :(
    # ... may be they will change it back
    if gif.nil? or gif.empty?
      random_gif_url = 'http://api.giphy.com/v1/gifs/screensaver?api_key=dc6zaTOxFJmzC'
      content = open(random_gif_url, "UserAgent" => "Ruby-Wget").read
      result = JSON.parse(content)
      height_200_url = result['data']['image_original_url'].sub 'original.gif', '200.gif'
      gif = {
              :images => {
                :fixed_height => {
                  :url => height_200_url
                }
              }
            }
    end

    respond_to do |format|
      #format.html { render json: gif }
      format.json { render json: gif }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :completed, :gif, :deleted)
    end
end
