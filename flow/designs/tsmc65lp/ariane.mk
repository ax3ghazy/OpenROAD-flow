export DESIGN_NAME = ariane
export PLATFORM    = tsmc65lp

export VERILOG_FILES = ./designs/src/ariane/design.v
export SDC_FILE      = ./designs/src/ariane/design.sdc

export ADDITIONAL_LEFS = ./platforms/tsmc65lp/tsmc65lp_1rf_lg8_w64_byte.lef
export ADDITIONAL_LIBS = ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg8_w64_byte_ss_1p08v_1p08v_125c.lib
export ADDITIONAL_GDS  = ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg8_w64_byte.gds2

export RUN_MACRO_PLACEMENT = 1

# These values must be multiples of placement site
export DIE_AREA    = 0 0 2200 1560
export CORE_AREA   = 10 12 2190 1550.4
export CORE_WIDTH  = 2180
export CORE_HEIGHT = 1538.4

export CLOCK_PERIOD = 5.600
export CLOCK_PORT   = clk_i
