
module registerfile(
    input [4:0]a1,a2,a3,
    input [31:0]wd,
    input clk,regwrite,
    output reg [31:0]rd1,rd2
    );
    reg [31:0] registers[31:0];
    always@(posedge clk)begin
    rd1 = registers[a1];
    rd2 = registers[a2];
    if(regwrite) registers[a3] = wd;
    end
    initial begin
    registers[3] <= 5;
    registers[4] <= 6;
    registers[1] <= 3;
    registers[2] <= 9;
    end
endmodule
