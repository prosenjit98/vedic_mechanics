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

  def other_settings
    breadcrumbs.add "other settings", other_settings_admin_settings_path
    @settings = AppConfiguration.find_by(key: "initial_category")
    @settings = AppConfiguration.new(key: "initial_category") if @settings.nil?
    @banner_massage = AppConfiguration.find_by(key: "banner_massage")
    @banner_massage = AppConfiguration.new(key: "banner_massage") if @banner_massage.nil?
    @whatsapp_massage_1 = AppConfiguration.find_by(key: "whatsapp_massage_1")
    @whatsapp_massage_1 = AppConfiguration.new(key: "whatsapp_massage_1") if @whatsapp_massage_1.nil?
    @whatsapp_massage_2 = AppConfiguration.find_by(key: "whatsapp_massage_2")
    @whatsapp_massage_2 = AppConfiguration.new(key: "whatsapp_massage_2") if @whatsapp_massage_2.nil?
    @parents = Category.parent_categories.order(:name)
    @errors = false
    if params[:app_configuration].present?
      params[:app_configuration].each do |key, value|
        @settings = AppConfiguration.find_by(key: value['key'])
        @settings = AppConfiguration.new(key: value['key']) if @settings.nil?
        @settings.value = value['value']
        unless @settings.save
          @errors = true
        end
      end
      unless @errors
        redirect_to other_settings_admin_settings_path, notice: "Settings updated"
      else
        redirect_to other_settings_admin_settings_path, alert: "Settings not updated"
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