class SearchRequest
  # annotations attribute should be a Hash object
  attr_accessor :image, :rpp, :page, :source, :category, :location, :heading,
    :body, :text, :external_id, :start, :end, :annotations,
    :trusted_annotations, :retvals

  def add_retval(retval)
    @retvals << retval
  end

  def query_params
    query = Hash.new
    url_params = ''
    #Perform a case insensitive match on the image attribute
    if (image =~ /\A(yes|no)/i))
      url_params += "image=#{image}&"
    end
    if (rpp.present?)
      query[:rpp] = rpp.to_s
      url_params += "rpp=#{CGI.escape(query[:rpp])}&"
    end
    if (page.present?)
      query[:page] = page.to_s
      url_params += "page=#{CGI.escape(query[:page])}&"
    end
    if (source.present?)
      query[:source] = source.to_s
      url_params += "source=#{CGI.escape(query[:source])}&"
    end
    if (category.present?)
      query[:category] = category.to_s
      url_params += "category=#{CGI.escape(query[:category])}&"
    end
    if (location.present?)
      query[:location] = location.to_s
      url_params += "location=#{CGI.escape(query[:location])}&"
    end
    if (heading.present?)
      query[:heading] = heading.to_s
      url_params += "heading=#{CGI.escape(query[:heading])}&"
    end
    if (body.present?)
      query[:body] = body.to_s
      url_params += "body=#{CGI.escape(query[:body])}&"
    end
    if (text.present?)
      query[:text] = text.to_s
      url_params += "text=#{CGI.escape(query[:text])}&"
    end
    if (external_id.present?)
      query[:external_id] = external_id.to_s
      url_params += "external_id=#{CGI.escape(query[:external_id])}&"
    end
    if (start.present?)
      query[:start] = start.to_s
      url_params += "start=#{CGI.escape(query[:start])}&"
    end
    if (self.end.present?)
      query[:end] = self.end.to_s
      url_params += "end=#{CGI.escape(query[:end])}&"
    end

    if (annotations.present? && annotations.size > 0)
#      query[:annotations] = ActiveSupport::JSON.encode(annotations)
      query[:annotations] = annotations
#      query.each do |key, value|
#        url_params += "#{key}=#{value}&"
#      end
      url_params += "annotations=#{CGI.escape(ActiveSupport::JSON.encode(query[:annotations]))}&" #'annotations=#{CGI.escape(ActiveSupport::JSON.encode(search.annotations))}'
    end
    if (trusted_annotations.present? && trusted_annotations.size > 0)
      #query[:trusted_annotations] = ActiveSupport::JSON.encode(trusted_annotations)
      query[:trusted_annotations] = trusted_annotations
      url_params += "trusted_annotations=#{CGI.escape(ActiveSupport::JSON.encode(query[:trusted_annotations]))}&"
    end
    if (retvals.present?)
      query[:retvals] = retvals.join(',')  #queryParams.put("retvals", Utils.join(retvals));
      url_params += "retvals=#{CGI.escape(query[:retvals])}&"
    end

    url_params
  end
end
