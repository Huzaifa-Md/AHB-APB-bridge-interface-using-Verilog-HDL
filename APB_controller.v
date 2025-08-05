`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:56 06/24/2025 
// Design Name: 
// Module Name:    APB_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module APB_controller(Hresetn, Hclk, valid,Hwrite,Haddr,Haddr1,Haddr2,Hwdata,Hwdata1,Hwdata2,Hwritereg,tempselx,Hreadyout,pwrite,penable,pselx,pwdata,paddr
    );
input Hclk, Hresetn,valid,Hwrite, Hwritereg;
input [2:0] tempselx;
input [31:0] Haddr,Haddr1,Haddr2,Hwdata,Hwdata1,Hwdata2;
output reg pwrite,penable,Hreadyout;
output reg[31:0] pwdata,paddr;
output reg[2:0] pselx;

parameter    st_idle=3'b000,
				 st_wait=3'b001,
				 st_write=3'b010,
				 st_writep=3'b011,
				 st_wenablep=3'b1001,
				 st_wenable=3'b101,
				 st_read=3'b110,
				 st_renable=3'b111;
		
reg[2:0] state,next_state,pselx_temp;
reg penable_temp, pwrite_temp,Hreadyout_temp;
reg[31:0] paddr_temp,pwdata_temp;


always@(posedge Hclk)
begin 
		if(!Hresetn)
		state<=st_idle;
		else
		state<= next_state;
	end
	
always@(*)
begin
 case(state)
     st_idle :  begin
							if((valid == 1'b1) && (Hwrite==1'b1))
							 next_state= st_wait;
							 else if ((valid==1'b1) && (Hwrite==1'b0))
							 next_state= st_read;
							 else
							 next_state= st_idle;
							 end
	 st_wait : begin
						if(valid==1'b1)
						next_state= st_writep;
						else
						next_state=st_write;
					end
	
	 st_writep: begin
							next_state= st_wenablep;
							end
	 st_write: begin
						if(valid==1'b1)
						next_state= st_wenablep;
						else
						next_state=st_wenable;
						end
	 st_wenablep: begin
						if((valid==1'b1) && (Hwritereg==1'b1))
						 next_state=st_writep;
						 else if ((valid ==1'b0) && (Hwritereg==1'b1))
						 next_state= st_write;
						 else
						 next_state= st_read;
						 end
						 
	 st_wenable: begin
							if((valid==1'b1)&& (Hwrite==1'b1))
								next_state = st_wait;
								else if ((valid==1'b1) && (Hwrite==1'b0))
									next_state=st_read;
									else 
									next_state= st_idle;
									end
	 st_read: begin
						next_state=st_renable;
						end
	st_renable: begin
							if((valid==1'b1) && (Hwrite==1'b1))
							next_state= st_wait;
							else if((valid==1'b1)&&(Hwrite==1'b0))
							next_state=st_read;
							else
							next_state=st_idle;
							end
	 default: 	next_state= st_idle;
					
		endcase
			end
			
			always@(*)
			begin
			case(state) 
						st_idle: begin
											
											if((valid==1'b1) && (Hwrite==1'b1))
											begin
											pselx_temp=3'd0;
											penable_temp=1'b0;
											Hreadyout_temp=1'b1;
											end
											else if((valid==1'b1) && (Hwrite==1'b0))
											begin
											paddr_temp=Haddr;
											pwrite_temp=1'b0;
											pselx_temp=tempselx;
											Hreadyout_temp=1'b0;
											penable_temp=1'b0;
											end
											else
											begin
											pselx_temp=1'b0;
											Hreadyout_temp=1'b1;
											penable_temp=1'b0;
											end
											end
								
								st_wait:  begin
													 paddr_temp=Haddr1;
													 pwrite_temp= Hwrite;
													 pselx_temp=tempselx;
													 Hreadyout_temp=1'b0;
													 pwdata_temp=Hwdata;
													 end
													 
								st_write: begin
													Hreadyout_temp=1'b1;
													penable_temp=1'b1;
													end
													
								st_writep : begin
														Hreadyout_temp=1'b1;
														penable_temp=1'b1;
														end
								st_wenablep: begin
														paddr_temp=Haddr2;
														Hreadyout_temp=1'b0;
														penable_temp=1'b0;
														pwdata_temp=Hwdata;
														end
														
								st_wenable: begin
														paddr_temp=Haddr2;
														Hreadyout_temp=1'b0;
														penable_temp=1'b0;
														pwdata_temp=Hwdata;
														end
														
								st_read: begin
												Hreadyout_temp=1'b1;
												penable_temp=1'b1;
												end
												
								st_renable: begin
														if((valid==1'b1) && (Hwrite==1'b0))
														begin
															pselx_temp=3'd0;
															penable_temp=1'b0;
															Hreadyout_temp=1'b1;
															end
														else if((valid==1'b1) && (Hwrite==1'b0))
															begin
															paddr_temp=Haddr;
															pwrite_temp= Hwrite;
															pselx_temp=tempselx;
															Hreadyout_temp= 1'b0;
															penable_temp=1'b0;
															end
															else
															begin
															pselx_temp=1'b0;
															Hreadyout_temp=1'b1;
															penable_temp=1'b0;
															end
															end
															endcase
															end
														
															
													
			
			
			
			always@(posedge Hclk)
			begin
			if(!Hresetn)
			begin
			penable<=0;
			pselx<=0;
			Hreadyout<= 1'b1;
			end
			
			else
			begin
			pwrite<=pwrite_temp;
			penable<= penable_temp;
			pselx<=pselx_temp;
			pwdata<= pwdata_temp;
			paddr<= paddr_temp;
			Hreadyout<= Hreadyout_temp;
			end
			end
			
			
			



endmodule
