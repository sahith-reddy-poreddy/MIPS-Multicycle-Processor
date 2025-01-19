
module control(
    output reg pcwrite, alusrcA, regwrite, mem2reg, IorD, memwrite, regdst, branch, pcsrc,irwrite,
    output reg [1:0]alusrcB,
    output reg [2:0]alucontrol,
    input [5:0] funct, op,
    input clk, reset
    );
    //State Machine for control
    parameter state1 = 4'd0, state2 = 4'd1, state3 = 4'd2, state4 = 4'd3, state5 = 4'd4,state6 = 4'd5, state7 = 4'd6, state8 = 4'd7, state9 =4'd8, state10= 4'd9, state11=4'd10;
    
    reg [3:0] state;
    initial begin 
    state = state1;
    end
    always@(posedge clk)begin
    case(state)
        state1 :begin//fetch the instructions
        case(op)
            6'b001000: state=state2;
            6'b100000: state=state5;
            6'b110000: state=state5;
            6'b000100: state=state9;
            default : state =state1;
         endcase
        end
        
        state2 :begin// execute the command
        state = state3;
        end
        
        state3 :begin// update PC
        state = state4;
        end
        
        state4 :begin// write back 
        state = state1; 
        end
        
        state5 : begin

        state = state6;
        end
        
        state6: begin
         case(op)
            6'b100000: state=state7;
            6'b110000: state=state8;
         endcase
        end
        
        state7: begin
        state = state3;
        end
        
        state8: begin
        state =state3;
        end
        state9: begin
        state =state10;
        end
        state10: state=state11;
        state11: state=state1;
    endcase
    end
    always@(state)begin
    case(state)
        state1:begin
        pcwrite = 0;
        alusrcA = 1;
        alusrcB = 2'b10;
        regwrite = 0;
        IorD = 0;
        memwrite = 0;
        irwrite =1 ;
        alucontrol = 3'b101;
        pcsrc = 0;
        mem2reg = 0;
        regdst = 1;
        end
        
        
        state2: begin
        pcwrite = 0;
        alusrcA = 1;
        alusrcB = 2'b10;
        regwrite = 0;
        alucontrol = 3'b010;
        end
        
        
        state3: begin
        alusrcA = 0;
        alusrcB = 0;
        alucontrol = 3'b010;
        pcwrite = 1;
        irwrite=1;
//        pcsrc = 0;
        if(op==6'b001000) regwrite = 1;
        memwrite =0;
        end
        
        
        state4: begin
        pcwrite = 0;
        alusrcA = 1;
        alusrcB = 1;
        regwrite = 0;
        alucontrol = 3'b101;
        end
        
        state5: begin
        alusrcA = 1;
        alusrcB = 2'b10;
        irwrite =0 ;
        alucontrol = 3'b010;
        IorD = 1;
        end
        
        state6: begin
        IorD =1;
        regdst =0;
        end
        
        state7: begin
        mem2reg=1;
        regwrite =1;
        end
        
        state8: begin
        memwrite =1;
        end
        
        state9: begin
        irwrite =0;
        alusrcA = 0;
        alusrcB = 2'b00;
        pcwrite =1;
        alucontrol = 3'b010;
        end
        
        state10: begin
        pcwrite =0;
        alusrcA =0;
        alusrcB =2'b10;
        alucontrol = 3'b010;
        end
        
        state11: begin
        pcwrite =0;
        alusrcA =1;
        alusrcB =2'b01;
        alucontrol = 3'b110;
        branch =1;
        pcsrc=1;
        irwrite = 1;
        end
    endcase
    end
    always@(posedge clk) begin
    if(reset==1)state =state1 ;
    end
endmodule
