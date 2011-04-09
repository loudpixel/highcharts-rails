module Highchart
  module Controller

    # Return three parameters: id of objects created, html code and chart object.
    def highchart_object(width, height, chart, id = nil)

      id = self.get_id if id == nil    
      
      chart.chart[:renderTo] = id
        
      html = self.generate_html(width, height, chart, id)
      return [id, html, chart]
  
    end

    def generate_html(width, height, chart, id)

      <<-HTML

  		<div id="#{id}" class="chart-container" style="width: #{width}px; height: #{height}px;"></div>

            <script type="text/javascript">
                #{chart.to_s}
        	  </script>  		
      HTML

    end

    def get_id(preffix = 'highchart')
      @special_hash = Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}/#{@ofc_url}"))[0..7]
      @special_hash = @special_hash.gsub(/[^a-zA-Z0-9]/,rand(10).to_s)     
      return preffix.to_s+"_#{@special_hash}"
    end


  end

end
