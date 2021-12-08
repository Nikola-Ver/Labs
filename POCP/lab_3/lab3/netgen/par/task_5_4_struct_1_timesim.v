////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.15xf
//  \   \         Application: netgen
//  /   /         Filename: task_5_4_struct_1_timesim.v
// /___/   /\     Timestamp: Wed Oct 20 17:43:48 2021
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -s 3 -pcf task_5_4_struct_1.pcf -sdf_anno true -sdf_path netgen/par -insert_glbl true -insert_pp_buffers true -w -dir netgen/par -ofmt verilog -sim task_5_4_struct_1.ncd task_5_4_struct_1_timesim.v 
// Device	: 6slx9ftg256-3 (PRODUCTION 1.21 2012-04-23)
// Input file	: task_5_4_struct_1.ncd
// Output file	: E:\Xilinx\Labs\lab3\lab3\netgen\par\task_5_4_struct_1_timesim.v
// # of Modules	: 1
// Design Name	: task_5_4_struct_1
// Xilinx        : E:\Xilinx\14.1\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module task_5_4_struct_1 (
  CLK, R, S, Q, nQ
);
  input CLK;
  input R;
  input S;
  output Q;
  output nQ;
  wire CLK_BUFGP;
  wire R_IBUF_0;
  wire S_IBUF_0;
  wire R_CLK_DFF_2_44;
  wire a_45;
  wire R_CLK_DFF_2_inv;
  wire \CLK_BUFGP/IBUFG_0 ;
  wire nQ_OBUF_48;
  wire R_S_AND_2_o_inv;
  wire S_IBUF_6;
  wire R_IBUF_3;
  wire R_S_AND_2_o_inv_pack_1;
  wire R_R_OR_1_o;
  wire a_Z_3_o_MUX_7_o;
  wire \CLK_BUFGP/IBUFG_9 ;
  wire \NlwBufferSignal_Q_OBUFT/I ;
  wire \NlwBufferSignal_R_CLK_DFF_2/CLK ;
  wire \NlwBufferSignal_nQ_OBUF/I ;
  wire \NlwBufferSignal_CLK_BUFGP/BUFG/IN ;
  wire \NlwBufferSignal_a/CLK ;
  wire GND;
  wire VCC;
  initial $sdf_annotate("netgen/par/task_5_4_struct_1_timesim.sdf");
  X_IPAD #(
    .LOC ( "PAD185" ))
  S_11 (
    .PAD(S)
  );
  X_BUF #(
    .LOC ( "PAD185" ))
  S_IBUF (
    .O(S_IBUF_6),
    .I(S)
  );
  X_BUF #(
    .LOC ( "PAD185" ))
  \ProtoComp2.IMUX.1  (
    .I(S_IBUF_6),
    .O(S_IBUF_0)
  );
  X_OPAD #(
    .LOC ( "PAD139" ))
  Q_3 (
    .PAD(Q)
  );
  X_OBUFT #(
    .LOC ( "PAD139" ))
  Q_OBUFT (
    .I(\NlwBufferSignal_Q_OBUFT/I ),
    .O(Q),
    .CTL(R_CLK_DFF_2_inv)
  );
  X_IPAD #(
    .LOC ( "PAD183" ))
  R_7 (
    .PAD(R)
  );
  X_BUF #(
    .LOC ( "PAD183" ))
  R_IBUF (
    .O(R_IBUF_3),
    .I(R)
  );
  X_BUF #(
    .LOC ( "PAD183" ))
  \ProtoComp2.IMUX  (
    .I(R_IBUF_3),
    .O(R_IBUF_0)
  );
  X_BUF   \R_CLK_DFF_2/R_CLK_DFF_2_DMUX_Delay  (
    .I(R_S_AND_2_o_inv_pack_1),
    .O(R_S_AND_2_o_inv)
  );
  X_FF #(
    .LOC ( "SLICE_X4Y36" ),
    .INIT ( 1'b0 ))
  R_CLK_DFF_2 (
    .CE(R_S_AND_2_o_inv),
    .CLK(\NlwBufferSignal_R_CLK_DFF_2/CLK ),
    .I(R_R_OR_1_o),
    .O(R_CLK_DFF_2_44),
    .RST(GND),
    .SET(GND)
  );
  X_LUT6 #(
    .LOC ( "SLICE_X4Y36" ),
    .INIT ( 64'h00FFFF0000FFFF00 ))
  R_R_OR_1_o1 (
    .ADR0(1'b1),
    .ADR1(1'b1),
    .ADR2(1'b1),
    .ADR4(R_IBUF_0),
    .ADR3(S_IBUF_0),
    .ADR5(1'b1),
    .O(R_R_OR_1_o)
  );
  X_LUT5 #(
    .LOC ( "SLICE_X4Y36" ),
    .INIT ( 32'hFFFFFF00 ))
  R_S_AND_2_o_inv1 (
    .ADR0(1'b1),
    .ADR1(1'b1),
    .ADR2(1'b1),
    .ADR4(R_IBUF_0),
    .ADR3(S_IBUF_0),
    .O(R_S_AND_2_o_inv_pack_1)
  );
  X_OPAD #(
    .LOC ( "PAD135" ))
  nQ_18 (
    .PAD(nQ)
  );
  X_OBUF #(
    .LOC ( "PAD135" ))
  nQ_OBUF (
    .I(\NlwBufferSignal_nQ_OBUF/I ),
    .O(nQ)
  );
  X_CKBUF #(
    .LOC ( "BUFGMUX_X3Y13" ))
  \CLK_BUFGP/BUFG  (
    .I(\NlwBufferSignal_CLK_BUFGP/BUFG/IN ),
    .O(CLK_BUFGP)
  );
  X_LUT6 #(
    .LOC ( "SLICE_X3Y13" ),
    .INIT ( 64'h0F0F0F0F0F0F0F0F ))
  R_CLK_DFF_2_inv1_INV_0 (
    .ADR0(1'b1),
    .ADR1(1'b1),
    .ADR5(1'b1),
    .ADR3(1'b1),
    .ADR4(1'b1),
    .ADR2(R_CLK_DFF_2_44),
    .O(R_CLK_DFF_2_inv)
  );
  X_FF #(
    .LOC ( "SLICE_X4Y35" ),
    .INIT ( 1'b0 ))
  a (
    .CE(VCC),
    .CLK(\NlwBufferSignal_a/CLK ),
    .I(a_Z_3_o_MUX_7_o),
    .O(a_45),
    .RST(GND),
    .SET(GND)
  );
  X_LUT6 #(
    .LOC ( "SLICE_X4Y35" ),
    .INIT ( 64'h00FF00AA00FF00FF ))
  Mmux_a_Z_3_o_MUX_7_o11 (
    .ADR2(1'b1),
    .ADR1(1'b1),
    .ADR0(S_IBUF_0),
    .ADR4(a_45),
    .ADR3(R_IBUF_0),
    .ADR5(R_CLK_DFF_2_44),
    .O(a_Z_3_o_MUX_7_o)
  );
  X_IPAD #(
    .LOC ( "PAD172" ))
  CLK_15 (
    .PAD(CLK)
  );
  X_BUF #(
    .LOC ( "PAD172" ))
  \CLK_BUFGP/IBUFG  (
    .O(\CLK_BUFGP/IBUFG_9 ),
    .I(CLK)
  );
  X_BUF #(
    .LOC ( "PAD172" ))
  \ProtoComp2.IMUX.2  (
    .I(\CLK_BUFGP/IBUFG_9 ),
    .O(\CLK_BUFGP/IBUFG_0 )
  );
  X_LUT6 #(
    .LOC ( "SLICE_X5Y13" ),
    .INIT ( 64'h0C0C0C0C0C0C0C0C ))
  nQ1 (
    .ADR0(1'b1),
    .ADR5(1'b1),
    .ADR4(1'b1),
    .ADR3(1'b1),
    .ADR2(a_45),
    .ADR1(R_CLK_DFF_2_44),
    .O(nQ_OBUF_48)
  );
  X_BUF   \NlwBufferBlock_Q_OBUFT/I  (
    .I(a_45),
    .O(\NlwBufferSignal_Q_OBUFT/I )
  );
  X_BUF   \NlwBufferBlock_R_CLK_DFF_2/CLK  (
    .I(CLK_BUFGP),
    .O(\NlwBufferSignal_R_CLK_DFF_2/CLK )
  );
  X_BUF   \NlwBufferBlock_nQ_OBUF/I  (
    .I(nQ_OBUF_48),
    .O(\NlwBufferSignal_nQ_OBUF/I )
  );
  X_BUF   \NlwBufferBlock_CLK_BUFGP/BUFG/IN  (
    .I(\CLK_BUFGP/IBUFG_0 ),
    .O(\NlwBufferSignal_CLK_BUFGP/BUFG/IN )
  );
  X_BUF   \NlwBufferBlock_a/CLK  (
    .I(CLK_BUFGP),
    .O(\NlwBufferSignal_a/CLK )
  );
  X_ZERO   NlwBlock_task_5_4_struct_1_GND (
    .O(GND)
  );
  X_ONE   NlwBlock_task_5_4_struct_1_VCC (
    .O(VCC)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

