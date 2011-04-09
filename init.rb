require 'highchart'

ActionController::Base.send :include, Highchart::Controller
ActionView::Base.send :include, HighchartHelper