/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : L-2016.03-SP2
// Date      : Wed Apr 18 14:12:20 2018
/////////////////////////////////////////////////////////////


module alu ( in_a, in_b, opcode, alu_out, alu_zero, alu_carry );
  input [7:0] in_a;
  input [7:0] in_b;
  input [3:0] opcode;
  output [7:0] alu_out;
  output alu_zero, alu_carry;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29,
         N30, N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43,
         N44, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57,
         N58, N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, N69, N70, N71,
         N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83, N84, N85,
         N86, N87, N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99,
         N100, N101, N102, N103, N104, N105, N106, N107;

  GTECH_OR2 C99 ( .A(alu_out[7]), .B(alu_carry), .Z(N96) );
  GTECH_OR2 C100 ( .A(alu_out[6]), .B(N96), .Z(N97) );
  GTECH_OR2 C101 ( .A(alu_out[5]), .B(N97), .Z(N98) );
  GTECH_OR2 C102 ( .A(alu_out[4]), .B(N98), .Z(N99) );
  GTECH_OR2 C103 ( .A(alu_out[3]), .B(N99), .Z(N100) );
  GTECH_OR2 C104 ( .A(alu_out[2]), .B(N100), .Z(N101) );
  GTECH_OR2 C105 ( .A(alu_out[1]), .B(N101), .Z(N102) );
  GTECH_OR2 C106 ( .A(alu_out[0]), .B(N102), .Z(N103) );
  GTECH_NOT I_0 ( .A(N103), .Z(N104) );
  ADD_UNS_OP add_39 ( .A(in_a), .B(1'b1), .Z({N44, N43, N42, N41, N40, N39, 
        N38, N37, N36}) );
  SUB_UNS_OP sub_36 ( .A(in_a), .B(in_b), .Z({N35, N34, N33, N32, N31, N30, 
        N29, N28, N27}) );
  ADD_UNS_OP add_63 ( .A({1'b1, N78, N79, N80, N81, N82, N83, N84, N85}), .B(
        1'b1), .Z({N94, N93, N92, N91, N90, N89, N88, N87, N86}) );
  ADD_UNS_OP add_33 ( .A(in_a), .B(in_b), .Z({N26, N25, N24, N23, N22, N21, 
        N20, N19, N18}) );
  SUB_UNS_OP sub_42 ( .A(in_a), .B(1'b1), .Z({N53, N52, N51, N50, N49, N48, 
        N47, N46, N45}) );
  SELECT_OP C108 ( .DATA1({N26, N25, N24, N23, N22, N21, N20, N19, N18}), 
        .DATA2({N35, N34, N33, N32, N31, N30, N29, N28, N27}), .DATA3({N44, 
        N43, N42, N41, N40, N39, N38, N37, N36}), .DATA4({N53, N52, N51, N50, 
        N49, N48, N47, N46, N45}), .DATA5({1'b0, N54, N55, N56, N57, N58, N59, 
        N60, N61}), .DATA6({1'b0, N62, N63, N64, N65, N66, N67, N68, N69}), 
        .DATA7({1'b0, N70, N71, N72, N73, N74, N75, N76, N77}), .DATA8({1'b0, 
        1'b0, in_a[7:1]}), .DATA9({in_a, 1'b0}), .DATA10({1'b1, N78, N79, N80, 
        N81, N82, N83, N84, N85}), .DATA11({N94, N93, N92, N91, N90, N89, N88, 
        N87, N86}), .CONTROL1(N7), .CONTROL2(N8), .CONTROL3(N9), .CONTROL4(N10), .CONTROL5(N11), .CONTROL6(N12), .CONTROL7(N13), .CONTROL8(N14), .CONTROL9(
        N15), .CONTROL10(N16), .CONTROL11(N17), .Z({alu_carry, alu_out}) );
  GTECH_BUF B_0 ( .A(N95), .Z(alu_zero) );
  GTECH_AND2 C112 ( .A(N105), .B(N106), .Z(N0) );
  GTECH_NOT I_1 ( .A(opcode[3]), .Z(N105) );
  GTECH_NOT I_2 ( .A(opcode[2]), .Z(N106) );
  GTECH_NOT I_3 ( .A(opcode[1]), .Z(N1) );
  GTECH_NOT I_4 ( .A(opcode[0]), .Z(N2) );
  GTECH_AND2 C117 ( .A(opcode[2]), .B(N1), .Z(N3) );
  GTECH_AND2 C118 ( .A(opcode[2]), .B(opcode[1]), .Z(N4) );
  GTECH_AND2 C119 ( .A(opcode[3]), .B(N1), .Z(N5) );
  GTECH_AND2 C120 ( .A(opcode[3]), .B(opcode[1]), .Z(N6) );
  GTECH_AND2 C121 ( .A(N0), .B(N1), .Z(N7) );
  GTECH_AND2 C122 ( .A(N0), .B(N2), .Z(N8) );
  GTECH_AND2 C123 ( .A(N107), .B(opcode[0]), .Z(N9) );
  GTECH_AND2 C124 ( .A(N0), .B(opcode[1]), .Z(N107) );
  GTECH_AND2 C125 ( .A(N3), .B(N2), .Z(N10) );
  GTECH_AND2 C126 ( .A(N3), .B(opcode[0]), .Z(N11) );
  GTECH_AND2 C127 ( .A(N4), .B(N2), .Z(N12) );
  GTECH_AND2 C128 ( .A(N4), .B(opcode[0]), .Z(N13) );
  GTECH_AND2 C129 ( .A(N5), .B(N2), .Z(N14) );
  GTECH_AND2 C130 ( .A(N5), .B(opcode[0]), .Z(N15) );
  GTECH_AND2 C131 ( .A(N6), .B(N2), .Z(N16) );
  GTECH_AND2 C132 ( .A(N6), .B(opcode[0]), .Z(N17) );
  GTECH_BUF B_1 ( .A(N7) );
  GTECH_BUF B_2 ( .A(N8) );
  GTECH_BUF B_3 ( .A(N9) );
  GTECH_BUF B_4 ( .A(N10) );
  GTECH_OR2 C148 ( .A(in_a[7]), .B(in_b[7]), .Z(N54) );
  GTECH_OR2 C149 ( .A(in_a[6]), .B(in_b[6]), .Z(N55) );
  GTECH_OR2 C150 ( .A(in_a[5]), .B(in_b[5]), .Z(N56) );
  GTECH_OR2 C151 ( .A(in_a[4]), .B(in_b[4]), .Z(N57) );
  GTECH_OR2 C152 ( .A(in_a[3]), .B(in_b[3]), .Z(N58) );
  GTECH_OR2 C153 ( .A(in_a[2]), .B(in_b[2]), .Z(N59) );
  GTECH_OR2 C154 ( .A(in_a[1]), .B(in_b[1]), .Z(N60) );
  GTECH_OR2 C155 ( .A(in_a[0]), .B(in_b[0]), .Z(N61) );
  GTECH_AND2 C156 ( .A(in_a[7]), .B(in_b[7]), .Z(N62) );
  GTECH_AND2 C157 ( .A(in_a[6]), .B(in_b[6]), .Z(N63) );
  GTECH_AND2 C158 ( .A(in_a[5]), .B(in_b[5]), .Z(N64) );
  GTECH_AND2 C159 ( .A(in_a[4]), .B(in_b[4]), .Z(N65) );
  GTECH_AND2 C160 ( .A(in_a[3]), .B(in_b[3]), .Z(N66) );
  GTECH_AND2 C161 ( .A(in_a[2]), .B(in_b[2]), .Z(N67) );
  GTECH_AND2 C162 ( .A(in_a[1]), .B(in_b[1]), .Z(N68) );
  GTECH_AND2 C163 ( .A(in_a[0]), .B(in_b[0]), .Z(N69) );
  GTECH_XOR2 C164 ( .A(in_a[7]), .B(in_b[7]), .Z(N70) );
  GTECH_XOR2 C165 ( .A(in_a[6]), .B(in_b[6]), .Z(N71) );
  GTECH_XOR2 C166 ( .A(in_a[5]), .B(in_b[5]), .Z(N72) );
  GTECH_XOR2 C167 ( .A(in_a[4]), .B(in_b[4]), .Z(N73) );
  GTECH_XOR2 C168 ( .A(in_a[3]), .B(in_b[3]), .Z(N74) );
  GTECH_XOR2 C169 ( .A(in_a[2]), .B(in_b[2]), .Z(N75) );
  GTECH_XOR2 C170 ( .A(in_a[1]), .B(in_b[1]), .Z(N76) );
  GTECH_XOR2 C171 ( .A(in_a[0]), .B(in_b[0]), .Z(N77) );
  GTECH_NOT I_5 ( .A(in_a[7]), .Z(N78) );
  GTECH_NOT I_6 ( .A(in_a[6]), .Z(N79) );
  GTECH_NOT I_7 ( .A(in_a[5]), .Z(N80) );
  GTECH_NOT I_8 ( .A(in_a[4]), .Z(N81) );
  GTECH_NOT I_9 ( .A(in_a[3]), .Z(N82) );
  GTECH_NOT I_10 ( .A(in_a[2]), .Z(N83) );
  GTECH_NOT I_11 ( .A(in_a[1]), .Z(N84) );
  GTECH_NOT I_12 ( .A(in_a[0]), .Z(N85) );
  GTECH_BUF B_5 ( .A(N17) );
  GTECH_BUF B_6 ( .A(N104), .Z(N95) );
endmodule

