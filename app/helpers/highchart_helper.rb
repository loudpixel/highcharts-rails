module HighchartHelper
  
def highchart_includes(fullscreen = false)
  includes = ''

  #includes << javascript_include_tag("http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js")  
  includes << javascript_include_tag("highcharts/highcharts.js")
  includes << javascript_include_tag("highcharts/modules/exporting.js")
  
  if fullscreen
    includes << stylesheet_link_tag('facebox/facebox.css')
    includes << javascript_include_tag("facebox/facebox.js")    
  	
  end
  
  includes
end

def highchart_fullscreen(chart, options = {})
  option = {:css_class => 'highchart_fullscreen', :text => 'Fullscreen', :width => '80%', :height => '80%'}
  options[:css_class] = option[:class_name] if options[:class_name] == nil
  options[:text] = option[:text] if options[:text] == nil
  options[:width] = option[:text] if options[:width] == nil
  options[:height] = option[:height] if options[:height] == nil
   
  
  <<-HTML
  
  <a href="#full_#{chart.chart[:renderTo]}" rel="facebox" class="#{options[:css_class]}" >#{options[:text]}</a>
     
	<div id="full_#{chart.chart[:renderTo]}" style="display: none; width: #{options[:width]}; height: #{options[:height]};"></div>

        <script type="text/javascript">            
            #{chart.fullscreen}
            
          	jQuery(document).ready(function($) {
          	  $('a[rel*=facebox]').facebox()
          	})

    	  </script>
	
	HTML
	  
end



end