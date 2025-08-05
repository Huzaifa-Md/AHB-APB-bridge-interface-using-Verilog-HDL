`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:49:57 07/01/2025 
// Design Name: 
// Module Name:    APB_Interface 
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
module APB_Interface(input penable,pwrite,input[2:0] pselx,
							input[31:0] paddr,pwdata,
							output pwrite_out,penable_out,
							output [2:0] pselx_out,
							output [31:0] paddr_out, pwdata_out,
							output reg[31:0] prdata
    );
	 
			assign pwrite_out = pwrite;
			assign penable_out = penable;
			assign pselx_out = pselx;
			assign paddr_out= paddr;
			assign  pwdata_out = pwdata;
			
			always@(*)
			begin
			if(!pwrite && penable)
			begin
			prdata= 8'd25;
			end
			end


endmodule
