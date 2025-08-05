`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:35 07/01/2025 
// Design Name: 
// Module Name:    AHB_master 
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
module AHB_master(input Hclk,Hresetn,Hreadyout,
						input [2:0] Hresp,
						input [31:0] Hrdata,
						output reg Hwrite,Hreadyin,
						output reg [31:0] Hwdata, Haddr,
						output reg [1:0] Htrans
    );
					reg [2:0] Hburst, Hsize;
					integer i,j;
					
					task single_write();
					begin
					@(posedge Hclk)
					#1;
					begin
					Hwrite= 1;
					Htrans = 2'b10;
					Hsize=0;
					Hburst=0;
					Hreadyin= 1;
					Haddr= 32'h8000_0001;
					end
					
					@(posedge Hclk)
					#1;
					begin
					Htrans=2'd0;
					Hwdata= 8'h80;
					end
					end
					endtask
					
					task single_read();
					begin
					@(posedge Hclk)
					begin
					Hwrite=0;
					Hreadyin=1;
					Htrans=2'b10;
					Hsize=0;
					Hburst=0;
					Haddr= 32'h8000_0001;
					end
					@(posedge Hclk)
					#1;
					begin
					Htrans=2'd0;
					end 
					end
					endtask
					
					task burst_write();
					begin
					@(posedge Hclk)
					#1;
					begin
					Hwrite=1'b1;
					Hreadyin=1;
					Hsize=0;
					Hburst=3'd3;
					Htrans=2'b10;
					Haddr= 32'h8000_0001;
					end
					@(posedge Hclk)
					#1;
					begin
					Haddr= Haddr +1'b1;
					Hwdata={$random}%256;
					Htrans= 2'b11;
					end
					for(i=0; i<2;i=i+1)
					begin
					@(posedge Hclk)
					#1;
					Haddr= Haddr+1;
					Hwdata={$random}%256;
					Htrans=2'b11;
					end
					@(posedge Hclk)
					#1;
					begin
					Hwdata={$random}%256;
					Htrans=2'b00;
					end
					end
					endtask
					
					
					


endmodule
