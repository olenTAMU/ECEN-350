`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    output  reg [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    //reg     [63:0] BusW;
    assign Zero = (BusW==64'b0)?1'b1:1'b0;
    always @(*) begin
       // $display("BUSA %b",BusA);
       // $display("BUSB %b",BusB);
       //$display("BUSW %b",BusW);
       //$display("ALU Zero %b",Zero);
       // $display("ALU CTRL %h",ALUCtrl);
        case(ALUCtrl)
            `AND: begin
                BusW = BusA & BusB;
            end
            `OR: begin
                BusW = BusA | BusB;
            end
            `ADD: begin
                BusW = BusA + BusB;
            end
            `SUB: begin
                BusW = BusA - BusB;
            end
            `PassB: begin
                //if(BusA < BusB) begin BusW = 1; Zero = 0; end
                //else begin BusW = 0; Zero = 1; end
                BusW = BusB;
            end
            
        endcase
    end

        
endmodule
