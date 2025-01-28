module dut_lab1(
  input pll_clk,
  input osc_clk,
  input ext_clk,
  input func_rst_n,

  input pll_cg_en,
  input osc_cg_en,
  input sys_cg_en,
  input clkmux_sel
);


logic pll_cg_clk;
logic osc_cg_clk;
logic sys_clk;
logic sys_clk_n;
logic sys_cg_clk_n;
logic ext_div5_seq_clk;
logic ext_div5_cg_clk;

logic neg_ff_cg;
logic neg_ff_cg_lib;
logic [3:0] ext_cnt;
logic [3:0] ext_cnt_sampled_div5_seq;
logic [3:0] ext_cnt_sampled_div5_cg;


// Lab1.1 - Instantiate icg_box modules below



// Lab1.2 - Design module gf_clk_mux and uncomment this section


  
// Lab1.3 - Generate sys_clk_n and instantiate its icg_box 


  
// Lab1.4 - Design module clk_div5_seq and instantiate below



// Lab1.5 - Design module clk_div5_cg and instantiate below




////////////////////////////////////////////////////////////////////////////////
// sys_clk domain logic
////////////////////////////////////////////////////////////////////////////////


// Compare mismatch of RTL vs GLS sim behaviour
// Flop described in RTL (RTL sim behaviour)
always @ (negedge sys_cg_clk_n or negedge func_rst_n)
  if(!func_rst_n)
    neg_ff_cg <= 1'b0;
  else
    neg_ff_cg <= !neg_ff_cg;

// The previous flop would be implemented with the following cell (GLS sim behaviour, using model from Std cell vendor)
SDFRRQJIHDX1 u_FF_from_lib (
  .C(!sys_cg_clk_n),
  .RN(func_rst_n),
  .SE(1'b0),
  .SD(1'b0),
  .D(!neg_ff_cg_lib),
  .Q(neg_ff_cg_lib)
);


////////////////////////////////////////////////////////////////////////////////
// ext_clk domain logic
////////////////////////////////////////////////////////////////////////////////


always @ (posedge ext_clk or negedge func_rst_n)
  if(!func_rst_n)
    ext_cnt <= 'h0;
  else 
    ext_cnt <= ext_cnt + 1'b1;


always @ (posedge ext_div5_seq_clk or negedge func_rst_n)
  if(!func_rst_n)
    ext_cnt_sampled_div5_seq <= 'h0;
  else
    ext_cnt_sampled_div5_seq <= ext_cnt;

always @ (posedge ext_div5_cg_clk or negedge func_rst_n)
  if(!func_rst_n)
    ext_cnt_sampled_div5_cg <= 'h0;
  else
    ext_cnt_sampled_div5_cg <= ext_cnt;

endmodule
