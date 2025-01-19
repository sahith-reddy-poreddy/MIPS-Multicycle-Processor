`timescale 1ns / 1ps

module processor(
    input clk, reset
    );
    reg [4:0]pc;
    reg [31:0] aluout;
    initial begin
    pc = 5'd0;
    end
    wire [31:0]srca , srcb, rd1, rd2, aluresult,imm, WriteData;
    wire regwrite,pcwrite,pcsrc, alusrcA,pcen, IorD, memwrite, regdst, irwrite, zero, branch, mem2reg;
    wire [1:0] alusrcB;
    wire [2:0]alucontrol;
    wire [4:0] Adr;
    assign pcen= (branch&zero)|pcwrite;
    always@(posedge clk) begin
    if(pcen==1) begin
        if(pcsrc==0)pc <= aluresult[4:0];
        else pc<=aluout[4:0];
     end
    aluout <= aluresult;
    if(reset ==1) pc= 5'd0;
    end
    assign Adr = IorD?aluout[4:0]:pc;
    assign WriteData = rd2;
//    assign srca = 32'd2;
//    assign srcb = 32'd2;
    wire [31:0]instr, data;

    instructions u_instructions(.clk(clk),.a(Adr),.instr(instr), .WriteData(WriteData), .memwrite(memwrite), .irwrite(irwrite), .data(data));
//    assign imm = 32'd2;
    assign imm = {16'd0,instr[15:0]};
    assign srca = alusrcA?rd1:{27'b0, pc};
    assign srcb = alusrcB[1]?imm:(alusrcB[0]?rd2:32'd1);
    wire [4:0]a1,a2,a3;
    wire [5:0] op;
    wire[31:0] wd;
    assign a1 = instr[25:21];
    assign a2 = instr[20:16];
    assign a3 = regdst?instr[15:11]:instr[20:16];
    assign op = instr[31:26];
    assign wd = mem2reg?data:aluout;
    registerfile u_register(.a1(a1),.a2(a2),.a3(a3),.wd(wd),.clk(clk),.regwrite(regwrite),.rd1(rd1),.rd2(rd2));
    alu u_alu(.srca(srca),.srcb(srcb), .alucontrol(alucontrol), .aluresult(aluresult), .zero(zero));
    control u_control(.pcwrite(pcwrite), .alusrcA(alusrcA), .alusrcB(alusrcB), .regwrite(regwrite),.alucontrol(alucontrol), .funct(instr[5:0]), .op(op), .clk(clk), .reset(reset), .IorD(IorD), .regdst(regdst), .branch(branch), .irwrite(irwrite), .pcsrc(pcsrc), .mem2reg(mem2reg), .memwrite(memwrite));
endmodule
