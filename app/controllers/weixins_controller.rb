class WeixinsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	#before_filter :check_weixin_legality
	def show
		render :text=> params[:echostr]
	end
	
	def create
		logger.debug "text:#{params[:xml]}"
		if params[:xml][:MsgType]=="text"
			render "echo",:format=>:xml
		end
	end
	
	def check_weixin_legality
	        #logger.debug params[:timestamp]
		array =["testtoken",params[:timestamp],params[:nonce]].sort
		render :text => "Forbidden",:status => 403 if params[:signature]!=Digest::SHA1.hexdigest(array.join)
	end
end
