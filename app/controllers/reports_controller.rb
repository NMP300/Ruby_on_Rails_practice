# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_created_report, only: [:edit, :update, :destroy]

  def index
    following_users = current_user.following
    @reports = Report.where(user_id: following_users).or(Report.where(user_id: current_user)).order(created_at: :DESC).page params[:page]
  end

  def show
    @report = Report.find_by(id: params[:id])
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
    if @report.update(report_params)
      redirect_to @report, notice: t("errors.messages.report_was_successfully_updated.")
    else
      render :edit
    end
  end

  def destroy
    if @report.destroy
      redirect_to reports_path, notice: t("errors.messages.report_was_successfully_destroyed.")
    else
      redirect_to @report
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_created_report
    @report = Report.find_by(id: params[:id], user_id: current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:title, :text, :user_id, pictures: [])
  end
end
