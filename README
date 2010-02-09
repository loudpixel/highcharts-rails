Highcharts_rails
================

Highcharts_rails is simply a helper to assist in the process of displaying highcharts graphs in your rails application. This plugin is completely dependent on the highcharts javascript library by Torstein Hønsi (http://highcharts.com).

The plugin will rarely need to be updated as new versions of the library come out, highcharts_rails accepts a combination of hashs and arrays that format themselves in a way that highcharts expects. 

The purpose of highcharts_rails is to allow developers to calculate chart data, and format chart data/labels/tooltips in the controller and/or model instead of doing so in the view. It cleans up views, and organizes models and controllers by dumping the work of formatting on the plugin.

This plugin is packed with Highcharts 1.1.3, and jQuery 1.3.2.

Usage
=======
Include the following in your <head /> tag
<%= javascript_include_tag 'jquery-1.3.2.min', 'highcharts' %>
<!--[if IE]>
	<%= javascript_include_tag 'excanvas.compiled' %>
<![endif]-->

As suggested by many sources some people like to put their javascript at the bottom of the page, regardless of your preference you should include the following to write your javascript, unless you feel it necessary to include your javascript in each view.
<script type="text/javascript">
	$(document).ready(function() {
		<%= yield :javascript %>
	});
</script>

We can collect all of our data, and format everything we need to in our controller:
# create a pie chart
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
	Highchart.pie({
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

In your views you can use a content block to provide the above your javascript, and markup for the highchart
<!-- container to hold the pie chart -->
<div id="pie-chart-container" class="chart-container"></div>
 
<% content_for :javascripts do %>
	<%= @pie_chart %>
<% end %>

The above will generate a string of javascript that will produce the Highcharts graph, and insert into the div. 

Example
=======

Three examples have been provided at {link to demo page}, with the project files available for download at {link to git hub project}


Copyright (c) 2010 Loudpixel Inc., released under the MIT license
