`timescale 1ns/100ps

module tb_lab1 ();

// Define Parameters and Logics

localparam sim_time = 4500; // Simulation time in ns

localparam pll_per = 10.0;   // PLL clock period in ns
localparam osc_per = 24.0;   // Oscillator period in ns
localparam ext_per = 64.0;   // External clock period in ns

logic pll_clk;
logic osc_clk;
logic ext_clk;
logic func_rst_n;
logic pll_cg_en;
logic osc_cg_en;
logic sys_cg_en;
logic clkmux_sel;

// Generate free-running clock sources

initial begin
    pll_clk = 1'b0;
    forever 
        pll_clk = #(pll_per/2) !pll_clk;
end

initial begin
    osc_clk = 1'b0;
    forever 
        osc_clk = #(osc_per/2) !osc_clk;
end

initial begin
    ext_clk = 1'b0;
    forever 
        ext_clk = #(ext_per/2) !ext_clk;
end

// Release functional reset before clock sources toggle

initial begin
    func_rst_n = 1'b0;
    #1ns;
    func_rst_n = 1'b1;
end

// Control Signals

assign sys_cg_en = 1'b1;  // tied high - is don't care

initial begin
	pll_cg_en = 1'b1;
        #500ns;
	@(posedge pll_clk);
        pll_cg_en = 1'b0; 

	#500ns;	
	@(posedge pll_clk);
        pll_cg_en = 1'b1; 

	#1500ns;	
	@(posedge pll_clk);
        pll_cg_en = 1'b0; 

	#1000ns;	
	@(posedge pll_clk);
        pll_cg_en = 1'b1; 


end

initial begin
	osc_cg_en = 1'b1;
        #500ns;
	@(posedge osc_clk);
        osc_cg_en = 1'b0; 
	#500ns;	
	@(posedge osc_clk);
        osc_cg_en = 1'b1; 
end


initial begin
	clkmux_sel = 1'b0;
	#1500ns;
        clkmux_sel = 1'b1; 
	#500ns;
        clkmux_sel = 1'b0;
	#1000ns;
        clkmux_sel = 1'b1; 
	#1000ns;
        clkmux_sel = 1'b0;	

end

// Dump waveforms and stop simulation
initial begin
    $shm_open(,1);
    $shm_probe("ACTM");
    #(sim_time);
    $finish();
end


// Instantiate DUT

dut_lab1 u_dut_lab1(
  .pll_clk(pll_clk),
  .osc_clk(osc_clk),
  .ext_clk(ext_clk),
  .func_rst_n(func_rst_n),
  .pll_cg_en(pll_cg_en),
  .osc_cg_en(osc_cg_en),
  .sys_cg_en(sys_cg_en),
  .clkmux_sel(clkmux_sel)
);



endmodule
