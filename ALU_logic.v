
module alu(
    input [31:0]srca, srcb,
    input [2:0]alucontrol,
    output reg [31:0]aluresult,
    output reg zero
    );
    always@(*)begin
    case(alucontrol)
        3'b010: aluresult=srca+srcb;
        3'b110: aluresult=srca-srcb;
        3'b000: aluresult=srca&srcb;
        3'b001: aluresult=srca|srcb;
        3'b111: aluresult=srca<srcb?32'd1:32'd0;
        default: aluresult=32'd0;
    endcase
        zero = aluresult?1'b0:1'b1;
    end
endmodule
