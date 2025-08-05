`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:58 06/23/2025 
// Design Name: 
// Module Name:    AHB_interface 
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
module AHB_interface(Hclk, Hresetn, Hwrite, Hreadyin, Htrans, Haddr, Hwdata,Hresp,Hrdata,Haddr1,Haddr2,Hwdata1,Hwdata2,Hwritereg,Hwritereg1,tempselx,prdata,valid
    );
input Hclk,Hresetn,Hwrite,Hreadyin;
input[1:0] Htrans;
input [31:0] Haddr, Hwdata, prdata;
output [1:0] Hresp;
output reg valid,Hwritereg,Hwritereg1;
output [31:0] Hrdata;
output reg[2:0] tempselx;
output reg[31:0] Haddr1,Haddr2,Hwdata1,Hwdata2;

always@(posedge Hclk)
begin 
		if(!Hresetn)
		begin
		Haddr1<=0;
		Haddr2<=0;
		end
		else
		begin
		Haddr1<=Haddr;
		Haddr2<= Haddr1;
		end
end
always@(posedge Hclk)
begin
	if(!Hresetn)
	begin
	Hwdata1<= 0;
	Hwdata2<=0;
	end
	else
	begin
	Hwdata1<=Hwdata;
	Hwdata2<=Hwdata1;
	end
end
always@(posedge Hclk)
begin
	if(!Hresetn)
	begin
	Hwritereg<=0;
	Hwritereg1<=0;
	end
	else
	begin
	Hwritereg<= Hwrite;
	Hwritereg1<=Hwritereg;
	end
end
always@(*)
begin 
	if(Haddr >= 32'h8000_0000 && Haddr <= 32'h8400_0000)
	tempselx = 3'b001;
	else if (Haddr >= 32'h8400_0000 && Haddr <= 32'h8800_0000)
	tempselx = 3'b010;
	else if (Haddr >= 32'h8800_0000 && Haddr <= 32'h8c00_0000)
	tempselx = 3'b100;
	else
	tempselx= 3'b000;
end

always@(*)
begin 
		if((Haddr >= 32'h8000_0000 && Haddr <= 32'h8c00_0000) && (Hreadyin ==1) && (Htrans == 2'b10 || Htrans == 2'b11))
		valid <=1'b1;
		else 
		valid <= 1'b0;
		end
		
		assign Hresp = 2'b0;
		assign Hrdata = prdata;
	

endmodule
