module ReportsHelper
  
  
  def graph_for(chart, args = {})
    high_chart(
        chart.name, 
   
        LazyHighCharts::HighChart.new('graph') do |f|
          f.options[:title] = {text: link_to(chart.title, report_path(chart.name))}
          f.options[:chart][:type] = "column"
          f.options[:chart][:height] = args[:height]
          f.series(:name => chart.x_axis_label, :data => chart.data.values)
          f.options[:xAxis] = {
            categories: chart.data.keys,
            labels: { 
              rotation: chart.x_axis_rotation ,
              align: 'left'
            }
          }
          f.options[:yAxis][:title] = {text: chart.y_axis_label} if chart.y_axis_label
          f.options[:xAxis][:title] = {text: chart.x_axis_label} if chart.x_axis_label
          f.options[:legend][:enabled] = false

        end
      )
  end
  
end
