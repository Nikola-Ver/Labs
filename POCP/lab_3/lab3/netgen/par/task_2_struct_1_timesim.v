////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.15xf
//  \   \         Application: netgen
//  /   /         Filename: task_2_struct_1_timesim.v
// /___/   /\     Timestamp: Mon Oct 18 03:01:39 2021
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -s 3 -pcf task_2_struct_1.pcf -sdf_anno true -sdf_path netgen/par -insert_glbl true -insert_pp_buffers true -w -dir netgen/par -ofmt verilog -sim task_2_struct_1.ncd task_2_struct_1_timesim.v 
// Device	: 6slx9ftg256-3 (PRODUCTION 1.21 2012-04-23)
// Input file	: task_2_struct_1.ncd
// Output file	: E:\Xilinx\Labs\lab3\lab3\netgen\par\task_2_struct_1_timesim.v
// # of Modules	: 1
// Design Name	: task_2_struct_1
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

module task_2_struct_1 (
  S, R, Q, nQ
);
  input S;
  input R;
  output Q;
  output nQ;
  wire Q_OBUF_20;
  wire S_IBUF_0;
  wire nQ_OBUF_22;
  wire R_IBUF_0;
  wire R_IBUF_3;
  wire S_IBUF_6;
  wire nQ_OBUF_pack_1;
  wire \NlwBufferSignal_nQ_OBUF/I ;
  wire \NlwBufferSignal_Q_OBUF/I ;
  initial $sdf_annotate("netgen/par/task_2_struct_1_timesim.sdf");
  X_OPAD #(
    .LOC ( "PAD124" ))
  nQ_14 (
    .PAD(nQ)
  );
  X_OBUF #(
    .LOC ( "PAD124" ))
  nQ_OBUF (
    .I(\NlwBufferSignal_nQ_OBUF/I ),
    .O(nQ)
  );
  X_IPAD #(
    .LOC ( "PAD122" ))
  R_7 (
    .PAD(R)
  );
  X_BUF #(
    .LOC ( "PAD122" ))
  R_IBUF (
    .O(R_IBUF_3),
    .I(R)
  );
  X_BUF #(
    .LOC ( "PAD122" ))
  \ProtoComp2.IMUX  (
    .I(R_IBUF_3),
    .O(R_IBUF_0)
  );
  X_IPAD #(
    .LOC ( "PAD123" ))
  S_11 (
    .PAD(S)
  );
  X_BUF #(
    .LOC ( "PAD123" ))
  S_IBUF (
    .O(S_IBUF_6),
    .I(S)
  );
  X_BUF #(
    .LOC ( "PAD123" ))
  \ProtoComp2.IMUX.1  (
    .I(S_IBUF_6),
    .O(S_IBUF_0)
  );
  X_OPAD #(
    .LOC ( "PAD121" ))
  Q_3 (
    .PAD(Q)
  );
  X_OBUF #(
    .LOC ( "PAD121" ))
  Q_OBUF (
    .I(\NlwBufferSignal_Q_OBUF/I ),
    .O(Q)
  );
  X_BUF   \Q_OBUF/Q_OBUF_AMUX_Delay  (
    .I(nQ_OBUF_pack_1),
    .O(nQ_OBUF_22)
  );
  X_LUT6 #(
    .LOC ( "SLICE_X10Y2" ),
    .INIT ( 64'h0055005500550055 ))
  \U1/b1  (
    .ADR4(1'b1),
    .ADR1(1'b1),
    .ADR2(1'b1),
    .ADR0(nQ_OBUF_22),
    .ADR3(R_IBUF_0),
    .ADR5(1'b1),
    .O(Q_OBUF_20)
  );
  X_LUT5 #(
    .LOC ( "SLICE_X10Y2" ),
    .INIT ( 32'h0F0A0F0A ))
  \U1/n00001  (
    .ADR4(1'b1),
    .ADR1(1'b1),
    .ADR2(S_IBUF_0),
    .ADR0(nQ_OBUF_22),
    .ADR3(R_IBUF_0),
    .O(nQ_OBUF_pack_1)
  );
  X_BUF   \NlwBufferBlock_nQ_OBUF/I  (
    .I(nQ_OBUF_22),
    .O(\NlwBufferSignal_nQ_OBUF/I )
  );
  X_BUF   \NlwBufferBlock_Q_OBUF/I  (
    .I(Q_OBUF_20),
    .O(\NlwBufferSignal_Q_OBUF/I )
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

