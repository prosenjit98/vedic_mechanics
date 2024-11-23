class Admin::SettingsController < Admin::BaseController 
  before_action :add_breadcrumbs

  def banner
    breadcrumbs.add "banner", banner_admin_settings_path
    @settings = AppConfiguration.find_by(key: "banner")
    @settings = AppConfiguration.new(key: "banner") if @settings.nil?
    if params[:app_configuration].present? && params[:app_configuration][:file].present?
      @settings.file.attach(params[:app_configuration][:file]) 
      if @settings.save
        redirect_to banner_admin_settings_path
      end
    end
  end

  private
  def add_breadcrumbs
    breadcrumbs.add "Settings", admin_settings_path
  end

  def settings_params
    params.require(:app_configuration).permit(:key, :value, :file)
  end
end