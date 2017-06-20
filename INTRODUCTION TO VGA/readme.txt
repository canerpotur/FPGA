The aim of this project is driving a VGA monitor using FPGA.
I used ALTERA 5CSEMA5F31 (Cyclone 5, DE1-soc)
Display mode: 640x480 
In this project:
        -->switch 0, 1, 2 determine the colour of the left of the screen
        -->switch 3, 4, 5 determine the colour of the right of the screen

Modules: top module-->vgaaa: Introducing inputs, outputs, submodules. 
         submodule--->vga_controller: Includes the codes for splitting and colouring the screen.