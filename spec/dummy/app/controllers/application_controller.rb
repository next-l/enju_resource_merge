class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, :with => :render_403
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_filter :set_locale
  
  private
  def render_403
    return if performed?
    if user_signed_in?
      respond_to do |format|
        format.html {render :template => 'page/403', :status => 403}
        format.xml {render :template => 'page/403', :status => 403}
        format.json
      end
    else
      respond_to do |format|
        format.html {redirect_to new_user_session_url}
        format.xml {render :template => 'page/403', :status => 403}
        format.json
      end
    end
  end

  def render_404
    return if performed?
    respond_to do |format|
      format.html {render :template => 'page/404', :status => 404}
      format.xml {render :template => 'page/404', :status => 404}
      format.json
    end
  end

  def set_locale
    if params[:locale]
      unless I18n.available_locales.include?(params[:locale].to_s.intern)
        raise InvalidLocaleError
      end
    end
    if user_signed_in?
      locale = params[:locale] || session[:locale] || current_user.locale.try(:to_sym)
    else
      locale = params[:locale] || session[:locale]
    end
    if locale
      I18n.locale = @locale = session[:locale] = locale.to_sym
    else
      I18n.locale = @locale = session[:locale] = I18n.default_locale
    end
  rescue InvalidLocaleError
    @locale = I18n.default_locale
  end

  def access_denied
    raise CanCan::AccessDenied
  end

  def get_series_statement
    @series_statement = SeriesStatement.find(params[:series_statement_id]) if params[:series_statement_id]
  end

  def get_patron
    @patron = Patron.find(params[:patron_id]) if params[:patron_id]
    authorize! :show, @patron if @patron
  end

  def get_patron_merge_list
    @patron_merge_list = PatronMergeList.find(params[:patron_merge_list_id]) if params[:patron_merge_list_id]
  end

  def get_series_statement_merge_list
    @series_statement_merge_list = SeriesStatementMergeList.find(params[:series_statement_merge_list_id]) if params[:series_statement_merge_list_id]
  end
end

class InvalidLocaleError < StandardError
end
