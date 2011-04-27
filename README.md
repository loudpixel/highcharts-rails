# highcharts-rails

Highcharts-rails is a simple helper for displaying Highcharts graphs in your Rails application. This plugin is completely dependent on the [Highcharts javascript library](http://highcharts.com) by Torstein Hønsi.

Highcharts-rails accepts a combination of hashes and arrays that formatted in a way that Highcharts expects and allows developers to calculate chart data and format chart data/labels/tooltips in the controller and/or model instead of the view.

This plugin is packaged with [Highcharts 1.1.3](http://highcharts.com/download), and [jQuery 1.3.2](http://docs.jquery.com/Release:jQuery_1.3.2).

This is a FORK of https://github.com/loudpixel/highcharts-rails. I have amplified it with some controller and helper methods.

## Installation

Get the plugin:

	script/plugin install git://github.com/rpperez/highcharts-rails.git
	
Run the rake setup:

	rake highcharts_rails:install

## Usage

Include the following in the head of your application layout:

	<%= highchart_includes(true) %>
	
You can use a boolean parameter to set fullscreen function. The fullscreen function uses a lightbox javascript make for (http://defunkt.io/facebox/).

This includes don't put jquery.js in your view. You need to put incorporate it for yourself.  

<%= javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" %>

We can collect all of our data, and format everything we need to in our controller:

	# Create a pie chart
	browser_data = [
	  {:name => 'Safari',               :y => 3.57,     :identifier => 'applewebkit'},
	  {:name => 'Firefox',              :y => 22.32,    :identifier => 'gecko'}, 
	  {:name => 'Internet Explorer',    :y => 56.9,     :identifier => 'msie'}, 
	  {:name => 'Other',                :y => 17.21}
	]

	user_agent = request.env['HTTP_USER_AGENT'].downcase

	# determine the users browser and pull that piece of the pie chart
	browser_data.each do |browser|
	  if user_agent.index(browser[:identifier].to_s)
	    browser[:sliced] = true
    
	    # some browsers will match more than one identifier, stop looking as soon as one is found
	    break;
	  end
	end

	# format the labels that show up on the chart
	pie_label_formatter = '
	  function() {
	    if (this.y > 15) return this.point.name;
	  }'

	# format the tooltips
	pie_tooltip_formatter = '
	  function() {
	    return "<strong>" + this.point.name + "</strong>: " + this.y + " %";
	  }'
  
	@pie_chart = 
		Highchart::Chart.pie({
	    :chart => {
			  :renderTo => "pie-chart-container",
			  :margin => [50, 30, 0, 30]
			},
			:credits => {
			  :enabled => true,
			  :href => 'http://marketshare.hitslink.com/browser-market-share.aspx?qprid=3',
			  :text => 'Data provided by NETMARKETSHARE'
			},
			:plotOptions => {
			  :pie => {
			    :dataLabels => {
			      :formatter => pie_label_formatter, 
			      :style => {
			        :textShadow => '#000000 1px 1px 2px'
			      }
			    }
			  }
			},
		  :series => [
				{
					:type => 'pie',
					:data => browser_data
				}
			],
			:subtitle => {
			  :text => 'January 2010'
			},
			:title => {
			  :text => 'Browser Market Share'
			},
			:tooltip => {
			  :formatter => pie_tooltip_formatter
			},
		})
		
	# Create the div's and javascript text in the same controller
	@output = highchart_object(300, 200, @pie_chart)

The hightchart_object method returns an array of three elements. The first element is an id that identified the div for your view. The second element is all the code that contains div and javascript text to make your chart. Finally, the third element is the chart. This is useful, if you want put the fullscreen link.

In your views you can use the output variable created in your controller:

	<%= @output[1] %>
	
If you want to put an link to fullscreen for the chart, you can do it with:

	<%= highchart_fullscreen(@output[2], {:width => "90%", :height => "90%"}) %>


Thanks to loudpixel for your contribution.
	
