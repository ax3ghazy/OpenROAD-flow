if {![info exists standalone] || $standalone} {
  # Read process files
  foreach libFile $::env(LIB_FILES) {
    read_liberty $libFile
  }
  read_lef $::env(OBJECTS_DIR)/merged_padded.lef
  
  # Read design files
  read_def $::env(RESULTS_DIR)/4_cts.def
}

set_wire_rc -layer $::env(WIRE_RC_LAYER)

# Give detail route more space for fixing DRC
fr_add_layer_adjustment 1 0.9
fr_add_layer_adjustment 2 0.5
fr_add_layer_adjustment 3 0.5

fastroute -capacity_adjustment 0.15 -max_routing_layer $::env(MAX_ROUTING_LAYER) \
  -output_file $::env(RESULTS_DIR)/route.guide

if {![info exists standalone] || $standalone} {
  exit
}
