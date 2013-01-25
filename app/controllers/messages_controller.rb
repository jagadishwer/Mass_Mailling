class MessagesController < ApplicationController
 # require 'roo'
 # require 'nokogiri'
 
  #require 'fileutils'
 # require 'iconv'
  #require 'spreadsheet'
  
  def new

  end
  def send_message
   @subject= params[:message][:subject]
    @message=params[:message][:message]
    @file_type=params[:message][:file_type]
    tmp = params[:message][:file].tempfile
    file = File.join("public", params[:message][:file].original_filename)
    FileUtils.cp tmp.path, file
    case @file_type.to_i

    when 1
    ss = Openoffice.new(file)
    when 2
    ss = Excel.new(file)
    when 3
    ss = Excelx.new(file)
    end
    ss.default_sheet = ss.sheets.first
    @name=[]
    2.upto(ss.last_row) do  |i|

#texter = Chagol::SmsSender.new("7799172077","3950","way2sms")
#texter.send("9866151732", "Chagol Rocks")
    UserMailer.mass_email(ss.cell(i,'A'),ss.cell(i,'C'),@subject,@message).deliver
    #@name<< "#{ss.cell(i,'A')}  #{ss.cell(i,'B')}  #{ss.cell(i,'C')}"

    end
    flash.now[:notice]="#{@count} Successfully Sent"
    FileUtils.rm file
    render 'new'
  end
  def sms
    #require 'chagol'
    texter = Chagol::SmsSender.new("9959956888","8642","160by2")
     texter.send("9866151732", "Chagol Rocks")
  end

end