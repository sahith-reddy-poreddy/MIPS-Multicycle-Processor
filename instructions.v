
module instructions(
    input clk,
    input [4:0]a,
    input [31:0]WriteData,
    input memwrite, irwrite,
    output reg [31:0] instr, data
    );
    reg [31:0] instructions[31:0];
    always@(posedge clk)begin
        if(memwrite==1'b1) instructions[a]=WriteData;
        if(irwrite==1)instr = instructions[a];
        data = instructions[a];
    end
    initial begin
    instructions[3]<=32'b000100_00001_00001_00000_00000_000010;
    instructions[0]<=32'b001000_00001_00011_00100_00000_000001; //addi
    instructions[1]<=32'b110000_00011_00011_00000_00000_000000;
    instructions[2]<=32'b100000_00001_00011_00000_00000_000000;
//    instructions[3]<=32'b000000_00001_00011_00100_00000_100101;
//    instructions[4]<=32'b000000_00001_00011_00100_00000_101010;
//    instructions[5]<=32'b000000_00001_00011_00110_00000_100000;
//    instructions[6]<=32'b000000_00001_00011_00110_00000_100010;
//    instructions[7]<=32'b000000_00001_00011_00110_00000_100100;
//    instructions[8]<=32'b000000_00001_00011_00110_00000_100101;
//    instructions[9]<=32'b000000_00001_00011_00110_00000_101010;
    
    end
endmodule
