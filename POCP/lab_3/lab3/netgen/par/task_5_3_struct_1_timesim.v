////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.15xf
//  \   \         Application: netgen
//  /   /         Filename: task_5_3_struct_1_timesim.v
// /___/   /\     Timestamp: Tue Oct 19 23:35:04 2021
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -s 3 -pcf task_5_3_struct_1.pcf -sdf_anno true -sdf_path netgen/par -insert_glbl true -insert_pp_buffers true -w -dir netgen/par -ofmt verilog -sim task_5_3_struct_1.ncd task_5_3_struct_1_timesim.v 
// Device	: 6slx9ftg256-3 (PRODUCTION 1.21 2012-04-23)
// Input file	: task_5_3_struct_1.ncd
// Output file	: E:\Xilinx\Labs\lab3\lab3\netgen\par\task_5_3_struct_1_timesim.v
// # of Modules	: 1
// Design Name	: task_5_3_struct_1
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

module task_5_3_struct_1 (
  CLK, R, D, Q, nQ
);
  input CLK;
  input R;
  input D;
  output Q;
  output nQ;
  wire D_IBUF_0;
  wire a_1_34;
  wire R_IBUF_0;
  wire \CLK_BUFGP/IBUFG_0 ;
  wire nQ_OBUF_37;
  wire CLK_BUFGP;
  wire a_39;
  wire D_IBUF_direct;
  wire R_IBUF_5;
  wire D_IBUF_1;
  wire \CLK_BUFGP/IBUFG_8 ;
  wire \ProtoComp2.D2OBYPSEL_GND.0 ;
  wire \ProtoComp2.D2OFFBYP_SRC.OUT ;
  wire \NlwBufferSignal_Q_OBUF/I ;
  wire \NlwBufferSignal_CLK_BUFGP/BUFG/IN ;
  wire \NlwBufferSignal_nQ_OBUF/I ;
  wire \NlwBufferSignal_a_1/CLK ;
  wire \NlwBufferSignal_a_1/IN ;
  wire \NlwBufferSignal_a/CLK ;
  wire \NlwBufferSignal_ProtoComp2.D2OFFBYP_SRC/INA ;
  wire \NlwBufferSignal_ProtoComp2.D2OBYP_SRC/INA ;
  wire VCC;
  wire GND;
  wire \NLW_ProtoComp2.D2OFFBYP_SRC_IB_UNCONNECTED ;
  wire \NLW_ProtoComp2.D2OBYP_SRC_IB_UNCONNECTED ;
  initial $sdf_annotate("netgen/par/task_5_3_struct_1_timesim.sdf");
  X_IPAD #(
    .LOC ( "PAD185" ))
  R_11 (
    .PAD(R)
  );
  X_BUF #(
    .LOC ( "PAD185" ))
  R_IBUF (
    .O(R_IBUF_5),
    .I(R)
  );
  X_BUF #(
    .LOC ( "PAD185" ))
  \ProtoComp0.IMUX.1  (
    .I(R_IBUF_5),
    .O(R_IBUF_0)
  );
  X_OPAD #(
    .LOC ( "PAD139" ))
  Q_7 (
    .PAD(Q)
  );
  X_OBUF #(
    .LOC ( "PAD139" ))
  Q_OBUF (
    .I(\NlwBufferSignal_Q_OBUF/I ),
    .O(Q)
  );
  X_IPAD #(
    .LOC ( "PAD183" ))
  D_4 (
    .PAD(D)
  );
  X_BUF #(
    .LOC ( "PAD183" ))
  D_IBUF (
    .O(D_IBUF_1),
    .I(D)
  );
  X_BUF #(
    .LOC ( "PAD183" ))
  \ProtoComp0.IMUX  (
    .I(D_IBUF_1),
    .O(D_IBUF_direct)
  );
  X_LUT6 #(
    .LOC ( "SLICE_X2Y20" ),
    .INIT ( 64'h00000000FFFFFFFF ))
  nQ1_INV_0 (
    .ADR0(1'b1),
    .ADR1(1'b1),
    .ADR2(1'b1),
    .ADR3(1'b1),
    .ADR4(1'b1),
    .ADR5(a_39),
    .O(nQ_OBUF_37)
  );
  X_CKBUF #(
    .LOC ( "BUFGMUX_X3Y13" ))
  \CLK_BUFGP/BUFG  (
    .I(\NlwBufferSignal_CLK_BUFGP/BUFG/IN ),
    .O(CLK_BUFGP)
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
  X_FF #(
    .LOC ( "OLOGIC_X2Y3" ),
    .INIT ( 1'b0 ))
  a_1 (
    .CE(VCC),
    .CLK(\NlwBufferSignal_a_1/CLK ),
    .I(\NlwBufferSignal_a_1/IN ),
    .O(a_1_34),
    .SET(GND),
    .RST(R_IBUF_0)
  );
  X_IPAD #(
    .LOC ( "PAD172" ))
  CLK_15 (
    .PAD(CLK)
  );
  X_BUF #(
    .LOC ( "PAD172" ))
  \CLK_BUFGP/IBUFG  (
    .O(\CLK_BUFGP/IBUFG_8 ),
    .I(CLK)
  );
  X_BUF #(
    .LOC ( "PAD172" ))
  \ProtoComp0.IMUX.2  (
    .I(\CLK_BUFGP/IBUFG_8 ),
    .O(\CLK_BUFGP/IBUFG_0 )
  );
  X_FF #(
    .LOC ( "ILOGIC_X0Y43" ),
    .INIT ( 1'b0 ))
  a (
    .CE(VCC),
    .CLK(\NlwBufferSignal_a/CLK ),
    .I(\ProtoComp2.D2OFFBYP_SRC.OUT ),
    .O(a_39),
    .SET(GND),
    .RST(R_IBUF_0)
  );
  X_MUX2 #(
    .LOC ( "ILOGIC_X0Y43" ))
  \ProtoComp2.D2OFFBYP_SRC  (
    .IA(\NlwBufferSignal_ProtoComp2.D2OFFBYP_SRC/INA ),
    .IB(\NLW_ProtoComp2.D2OFFBYP_SRC_IB_UNCONNECTED ),
    .O(\ProtoComp2.D2OFFBYP_SRC.OUT ),
    .SEL(\ProtoComp2.D2OBYPSEL_GND.0 )
  );
  X_MUX2 #(
    .LOC ( "ILOGIC_X0Y43" ))
  \ProtoComp2.D2OBYP_SRC  (
    .IA(\NlwBufferSignal_ProtoComp2.D2OBYP_SRC/INA ),
    .IB(\NLW_ProtoComp2.D2OBYP_SRC_IB_UNCONNECTED ),
    .O(D_IBUF_0),
    .SEL(\ProtoComp2.D2OBYPSEL_GND.0 )
  );
  X_ZERO #(
    .LOC ( "ILOGIC_X0Y43" ))
  \ProtoComp2.D2OBYPSEL_GND  (
    .O(\ProtoComp2.D2OBYPSEL_GND.0 )
  );
  X_BUF   \NlwBufferBlock_Q_OBUF/I  (
    .I(a_1_34),
    .O(\NlwBufferSignal_Q_OBUF/I )
  );
  X_BUF   \NlwBufferBlock_CLK_BUFGP/BUFG/IN  (
    .I(\CLK_BUFGP/IBUFG_0 ),
    .O(\NlwBufferSignal_CLK_BUFGP/BUFG/IN )
  );
  X_BUF   \NlwBufferBlock_nQ_OBUF/I  (
    .I(nQ_OBUF_37),
    .O(\NlwBufferSignal_nQ_OBUF/I )
  );
  X_BUF   \NlwBufferBlock_a_1/CLK  (
    .I(CLK_BUFGP),
    .O(\NlwBufferSignal_a_1/CLK )
  );
  X_BUF   \NlwBufferBlock_a_1/IN  (
    .I(D_IBUF_0),
    .O(\NlwBufferSignal_a_1/IN )
  );
  X_BUF   \NlwBufferBlock_a/CLK  (
    .I(CLK_BUFGP),
    .O(\NlwBufferSignal_a/CLK )
  );
  X_BUF   \NlwBufferBlock_ProtoComp2.D2OFFBYP_SRC/INA  (
    .I(D_IBUF_direct),
    .O(\NlwBufferSignal_ProtoComp2.D2OFFBYP_SRC/INA )
  );
  X_BUF   \NlwBufferBlock_ProtoComp2.D2OBYP_SRC/INA  (
    .I(D_IBUF_direct),
    .O(\NlwBufferSignal_ProtoComp2.D2OBYP_SRC/INA )
  );
  X_ONE   NlwBlock_task_5_3_struct_1_VCC (
    .O(VCC)
  );
  X_ZERO   NlwBlock_task_5_3_struct_1_GND (
    .O(GND)
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

