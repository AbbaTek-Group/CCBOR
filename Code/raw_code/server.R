function(input, output, session) {
  # Simple dashboard modules
  session$userData$state_view <- state_view$init_server("state_simple_view")
  city_view$init_server("city_simple_view")
  global_metrics_view$init_server("global_metrics_simple_view")

  # Advanced dashboard modules
  session$userData$map_view <- map_view$init_server("map_advanced_view")
  session$userData$state_view <- state_view$init_server("state_advanced_view")
  city_view$init_server("city_advanced_view")
  global_metrics_view$init_server("global_metrics_advanced_view")
  local_metrics_view$init_server("local_metrics_advanced_view")
}
