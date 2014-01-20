module ApplicationHelper

  def fix_url str
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime datetime
    datetime.nil? ? nil : datetime.strftime("%m%d%Y %l:%M%P %Z") 
    # 12/26/2013 18:10pm
  end

end
