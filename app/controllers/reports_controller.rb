# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    following_users = current_user.following
    @reports = Report.where(user_id: following_users).or(Report.where(user_id: current_user)).order(created_at: :DESC).page params[:page]
  end

  def show
    @comments = @report.comments
    @comment = Comment.new
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params.merge(user_id: current_user.id))

    if @report.save
      redirect_to @report, notice: t("errors.messages.report_was_successfully_created.")
    else
      render :new
    end
  end

  def update
    if created_user?
      if @report.update(report_params)
        redirect_to @report, notice: t("errors.messages.report_was_successfully_updated.")
      else
        render :edit
      end
    end
  end

  def destroy
    if created_user?
      @report.destroy
      redirect_to reports_path, notice: t("errors.messages.report_was_successfully_destroyed.")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:title, :text, :user_id, pictures: [])
  end

  def created_user?
    current_user == @report.user
  end
end
