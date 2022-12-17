module SCPU(
    // Input signals
    clk,
    rst_n,
    in_valid,
    instruction,
    MEM_out,
    // Output signals
    busy,
    out_valid,
    out0,
    out1,
    out2,
    out3,
    out4,
    out5,
    out6,
    out7,
    out8,
    out9,
    out10,
    out11,
    out12,
    out13,
    out14,
    out15,
    WEN,
    ADDR,
    MEM_in
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input clk, rst_n, in_valid;
input [18:0] instruction;
output reg busy, out_valid;
output reg signed [15:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15;

input signed [15:0] MEM_out;
output reg WEN;
output reg signed [15:0] MEM_in;
output reg [12:0] ADDR;

//---------------------------------------------------------------------
//   WIRE AND REG DECLARATION
//---------------------------------------------------------------------

reg [2:0] opcode;
reg [3:0] rs_s1, rt_s1, rd_s1, rl_s1;
reg [3:0] rs_s2, rt_s2, rd_s2, rl_s2;
reg [3:0] rt_s3, rd_s3, rl_s3;
reg [3:0] rt_s4, rd_s4, rl_s4;
reg [3:0] rt_s5, rd_s5, rl_s5;
reg [3:0] func;
reg signed [7:0] imm_s1, imm_s2, imm_s3;
reg in_valid_s1, in_valid_s2, in_valid_s3, in_valid_s4, in_valid_s5;
reg signed [18:0] instruction_s1;
reg [4:0] calculate_s1, calculate_s2, calculate_s3, calculate_s4, calculate_s5;
reg signed [15:0] register [15:0];
reg signed [15:0] rs_data_s2, rt_data_s2, rd_data_s2, rl_data_s2;
reg signed [15:0] rs_data_s3, rt_data_s3, rd_data_s3, rl_data_s3;
reg signed [31:0] alu_result, alu_result_s4, alu_result_s5;
//reg WEN_s1, WEN_s2, WEN_s3, WEN_s4, WEN_s5;
//reg signed [15:0] MEM_in_s4, MEM_in_s5;
reg signed [15:0] load_memory, load_memory_s5;

//---------------------------------------------------------------------
//   Design Description
//---------------------------------------------------------------------

parameter IDLE = 0;
parameter AND = 1;
parameter OR = 2;
parameter XOR = 3;
parameter ADD = 4;
parameter SUB = 5;
parameter MULT = 6;
parameter BEQ = 7;
parameter SLT = 8;
parameter ADDI = 9;
parameter SUBI = 10;
parameter STORE = 11;
parameter LOAD = 12;



always@(posedge clk,negedge rst_n)begin
	if(!rst_n)begin
		in_valid_s1 <= 0;
		in_valid_s2 <= 0;
		in_valid_s3 <= 0;
		in_valid_s4 <= 0;
		in_valid_s5 <= 0;
		instruction_s1 <= 0;
		busy <= 0;
		out_valid <= 0;
		out0 <= 0;
		out1 <= 0;
		out2 <= 0;
		out3 <= 0;
		out4 <= 0;
		out5 <= 0;
		out6 <= 0;
		out7 <= 0;
		out8 <= 0;
		out9 <= 0;
		out10 <= 0;
		out11 <= 0;
		out12 <= 0;
		out13 <= 0;
		out14 <= 0;
		out15 <= 0;
		WEN <= 1;
		//ADDR <= 0;
		//MEM_in <= 0;
	end
	else begin
		busy <= 0;
		
		out0 <= register[0];
		out1 <= register[1];
		out2 <= register[2];
		out3 <= register[3];
		out4 <= register[4];
		out5 <= register[5];
		out6 <= register[6];
		out7 <= register[7];
		out8 <= register[8];
		out9 <= register[9];
		out10 <= register[10];
		out11 <= register[11];
		out12 <= register[12];
		out13 <= register[13];
		out14 <= register[14];
		out15 <= register[15];
		in_valid_s1 <= in_valid;
		instruction_s1 <= instruction;
		
		in_valid_s2 <= in_valid_s1;
		rs_s2 <= rs_s1;
		rt_s2 <= rt_s1;
		rd_s2 <= rd_s1;
		rl_s2 <= rl_s1;
		imm_s2 <= imm_s1;
		calculate_s2 <= calculate_s1;
		
		
		in_valid_s3 <= in_valid_s2;
		rt_s3 <= rt_s2;
		rd_s3 <= rd_s2;
		rl_s3 <= rl_s2;
		rs_data_s3 <= rs_data_s2;
		rt_data_s3 <= rt_data_s2;
		rd_data_s3 <= rd_data_s2;
		rl_data_s3 <= rl_data_s2;
		imm_s3 <= imm_s2;
		calculate_s3 <= calculate_s2;
		if( calculate_s2 == STORE ) begin			
			WEN <= 0;
		end
		else if( calculate_s2 == LOAD ) begin
			WEN <= 1;
		end
		MEM_in <= rt_data_s2;
		
		in_valid_s4 <= in_valid_s3;
		rt_s4 <= rt_s3;
		rd_s4 <= rd_s3;
		rl_s4 <= rl_s3;
		alu_result_s4 <= alu_result;
		calculate_s4 <= calculate_s3;
		//MEM_in <= rt_data_s3;
		//MEM_in <= register[rt_s3];
		//ADDR <= alu_result[12:0];
		
				
		
		in_valid_s5 <= in_valid_s4;
		rt_s5 <= rt_s4;
		rd_s5 <= rd_s4;
		rl_s5 <= rl_s4;
		alu_result_s5 <= alu_result_s4;
		calculate_s5 <= calculate_s4;
		load_memory_s5 <= load_memory;
		
		out_valid <= in_valid_s5;
		
	end
end

always@(*) begin
	register[0] = out0;
	register[1] = out1;
	register[2] = out2;
	register[3] = out3;
	register[4] = out4;
	register[5] = out5;
	register[6] = out6;
	register[7] = out7;
	register[8] = out8;
	register[9] = out9;
	register[10] = out10;
	register[11] = out11;
	register[12] = out12;
	register[13] = out13;
	register[14] = out14;
	register[15] = out15;
	calculate_s1 = IDLE;	
	rs_s1 = instruction_s1[15:12];
	rt_s1 = instruction_s1[11:8];
	rd_s1 = instruction_s1[7:4];
	rl_s1 = instruction_s1[3:0];
	imm_s1 = instruction_s1[7:0];
	rs_data_s2 = 0;
	rt_data_s2 = 0;
	rd_data_s2 = 0;
	rl_data_s2 = 0;
	alu_result = 0;
	load_memory = 0;
	ADDR = 0;
	//MEM_in = 0;
	
	if( in_valid_s1 ) begin
		case( instruction_s1[18:16] )
			3'b000: begin
				case( instruction_s1[3:0] )
					4'b0000: begin
						calculate_s1 = AND;
					end
					4'b0001: begin
						calculate_s1 = OR;
					end
					4'b0010: begin
						calculate_s1 = XOR;
					end
					4'b0011: begin
						calculate_s1 = ADD;
					end
					4'b0100: begin
						calculate_s1 = SUB;
					end
				endcase
			end
			3'b001: begin
				calculate_s1 = MULT;
			end
			3'b010: begin
				calculate_s1 = BEQ;
			end
			3'b111: begin
				calculate_s1 = SLT;
			end
			3'b011: begin
				calculate_s1 = ADDI;
			end
			3'b100: begin
				calculate_s1 = SUBI;
			end
			3'b101: begin
				calculate_s1 = STORE;
			end
			3'b110: begin
				calculate_s1 = LOAD;
			end
		endcase
	end
	
	
	rs_data_s2 = register[rs_s2];
	rt_data_s2 = register[rt_s2];
	rd_data_s2 = register[rd_s2];
	rl_data_s2 = register[rl_s2];
	
	
	case( calculate_s3 )
		AND: begin
			alu_result = rs_data_s3 & rt_data_s3;
		end
		OR: begin
			alu_result = rs_data_s3 | rt_data_s3;
		end
		XOR: begin
			alu_result = rs_data_s3 ^ rt_data_s3; 
		end
		ADD: begin
			alu_result = rs_data_s3 + rt_data_s3;
		end
		SUB: begin
			alu_result = rs_data_s3 - rt_data_s3;
		end
		MULT: begin
			alu_result = rs_data_s3 * rt_data_s3;
		end
		BEQ: begin
			if( rs_data_s3 == rt_data_s3 ) begin
				alu_result = 1;
			end
			else begin
				alu_result = 0;
			end
		end
		SLT: begin
			if( rs_data_s3 < rt_data_s3 ) begin
				alu_result = 1;
			end
			else begin
				alu_result = 0;
			end
		end
		ADDI: begin
			alu_result = rs_data_s3 + imm_s3;
		end
		SUBI: begin
			alu_result = rs_data_s3 - imm_s3;
		end
		STORE: begin
			alu_result = rs_data_s3[12:0] + imm_s3;
			ADDR = alu_result[12:0];
		end
		LOAD: begin
			alu_result = rs_data_s3[12:0] + imm_s3;
			ADDR = alu_result[12:0];
		end
		/*default: begin
			alu_result = 0;
		end*/
	endcase
	
	//ADDR = alu_result[12:0];
	
	if( calculate_s4 == LOAD ) begin
		load_memory = MEM_out;
	end
	/*if( calculate_s4 == STORE ) begin
		MEM_in = register[rt_s4];
	end*/
	
	case( calculate_s5 )
		AND, OR, XOR, ADD, SUB: begin
			register[rd_s5] = alu_result_s5[15:0];
		end
		MULT: begin
			register[rd_s5] = alu_result_s5[31:16];
			register[rl_s5] = alu_result_s5[15:0];
		end
		BEQ: begin
			if( alu_result_s5 == 1 ) begin
				register[rd_s5] = 1;
				register[rl_s5] = 0;
			end
			else begin
				register[rd_s5] = 0;
				register[rl_s5] = 1;
			end
		end
		SLT: begin
			if( alu_result_s5 == 1 ) begin
				register[rd_s5] = 1;
				register[rl_s5] = 0;
			end
			else begin
				register[rd_s5] = 0;
				register[rl_s5] = 1;
			end
		end
		ADDI, SUBI: begin
			register[rt_s5] = alu_result_s5[15:0];
		end
		LOAD: begin
			register[rt_s5] = load_memory_s5;
		end
	endcase
	
end



endmodule