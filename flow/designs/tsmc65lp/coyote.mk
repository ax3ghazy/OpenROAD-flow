export DESIGN_NAME = bsg_rocket_node_client_rocc
export PLATFORM    = tsmc65lp

export VERILOG_FILES = ./designs/src/coyote/design.v
export SDC_FILE      = ./designs/src/coyote/design.sdc

export ADDITIONAL_LEFS = ./platforms/tsmc65lp/tsmc65lp_1rf_lg6_w80_bit.lef \
                         ./platforms/tsmc65lp/tsmc65lp_1rf_lg8_w128_all.lef \
                         ./platforms/tsmc65lp/tsmc65lp_2rf_lg6_w44_bit.lef \
                         ./platforms/tsmc65lp/tsmc65lp_2rf_lg6_w44_bit.lef \
                         ./platforms/tsmc65lp/tsmc65lp_2rf_lg8_w64_bit.lef \
                         ./platforms/tsmc65lp/tsmc65lp_2rf_lg8_w64_bit.lef
export ADDITIONAL_LIBS = ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w80_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg8_w128_all_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_2rf_lg6_w44_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_2rf_lg6_w44_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_2rf_lg8_w64_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_2rf_lg8_w64_bit_ss_1p08v_1p08v_125c.lib
export ADDITIONAL_GDS  = ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w80_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg8_w128_all.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_2rf_lg6_w44_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_2rf_lg6_w44_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_2rf_lg8_w64_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_2rf_lg8_w64_bit.gds2


export RUN_MACRO_PLACEMENT = 1

# These values must be multiples of placement site
export DIE_AREA    = 0.0 0.0 4200 1860
export CORE_AREA   = 10 12 4190 1850.4
export CORE_WIDTH  = 4180
export CORE_HEIGHT = 1838.4

export CLOCK_PERIOD = 5.600
export CLOCK_PORT   = clk_i
