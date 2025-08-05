`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:08:59 07/02/2025 
// Design Name: 
// Module Name:    ahb2apb 
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
module ahb2apb(input Hclk,Hresetn,Hwrite,Hreadyin,
						input [31:0] Hwdata, Haddr, prdata,
						input[1:0] Htrans,
						output pwrite, penable,Hreadyout,
						output [2:0] pselx,
						output [31:0] paddr, pwdata,Hrdata
			
    );
	 
						wire valid;
						wire [31:0] Hwdata_1,Hwdata_2,Haddr_1,Haddr_2;
						wire [2:0] temp_selx;
						wire [1:0] Hresp;
						
						AHB_interface ahb_S(Hclk, Hresetn, Hwrite, Hreadyin, Htrans, Haddr, Hwdata,Hresp,Hrdata,Haddr1,Haddr2,Hwdata1,Hwdata2,Hwritereg,Hwritereg1,temp_selx,prdata,valid);
						
						APB_controller apb_c(Hresetn, Hclk, valid,Hwrite,Haddr,Haddr1,Haddr2,Hwdata,Hwdata1,Hwdata2,Hwritereg,tempselx,Hreadyout,pwrite,penable,pselx,pwdata,paddr);
   
   


endmodule

