if {![info exists standalone] || $standalone} {
  # Read process files
  foreach libFile $::env(LIB_FILES) {
    read_liberty $libFile
  }
  read_lef $::env(OBJECTS_DIR)/merged_padded.lef

  # Read design files
  read_def $::env(RESULTS_DIR)/2_3_floorplan_tdms.def
  read_sdc $::env(RESULTS_DIR)/1_synth.sdc
}

proc fix_macro_as_west {} {
  set db [::ord::get_db]
  set block [[$db getChip] getBlock]
  foreach inst [$block getInsts] {
    set inst_master [$inst getMaster]

    # BLOCK means MACRO cells
    # Set macrocells as West
    if { [string match [$inst_master getType] "BLOCK"] } {
      $inst setOrient R90
      $inst setPlacementStatus PLACED
      $inst setLocation 0 0
    }
  }
  return
}

puts "Fix macro orientation for 65nm"
fix_macro_as_west

macro_placement -global_config $::env(IP_GLOBAL_CFG)

if {![info exists standalone] || $standalone} {
  write_def $::env(RESULTS_DIR)/2_4_floorplan_macro.def
  exit
}
