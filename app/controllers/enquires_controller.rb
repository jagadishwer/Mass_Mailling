class EnquiresController < ApplicationController
  def new
  end
  def create
    @file_type=params[:message][:file_type]
    tmp = params[:message][:file].tempfile
    file = File.join("public", params[:message][:file].original_filename)
    FileUtils.cp tmp.path, file
    unless @file_type.nil?
      case @file_type.to_i

      when 1
        ss = Openoffice.new(file)
      when 2
        ss = Excel.new(file)
      when 3
        ss = Excelx.new(file)
      end
      ss.default_sheet = ss.sheets.first
      @count=0
      2.upto(ss.last_row) do  |i|

   
        @enquiry=Enquiry.new(:name=>ss.cell(i,'A'),:phone_no=>ss.cell(i,'B').to_i,:email=>ss.cell(i,'C'),:course=>ss.cell(i,'D'))
        if @enquiry.save
          @count+=1
        end
      end
      flash.now[:notice]="#{@count} Successfully Saved"
    else
       flash.now[:error]="Select File Type"
    end

  end
  def edit
  end

  def show
    @enquires=Enquiry.paginate(:page => params[:page], :per_page =>2)
  end
  def send_mail
    if request.post?
      @subject_text= params['message']['subject']
      @message_text = params['message']['message']
      @enquires=Enquiry.all
      @enquires.each do |e|
        UserMailer.mass_email(e.name,e.email,@subject_text,@message_text).deliver

      end
       flash.now[:notice]="Sucessfully Sent"
      #render :text=>"sucessfully sent"
    end
  end
  def add_contact
    if request.post?
      @enquiry = Enquiry.new(params[:contact])
      if @enquiry.save
        flash.now[:notice]="Sucessfully Saved"
      else
        flash.now[:error]="Something went wrong"
      end

    end
  end
end
