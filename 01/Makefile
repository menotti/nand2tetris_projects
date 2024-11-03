all test.out: 
	iverilog -o test.out *.v

run dump.vcd: test.out
	vvp test.out

sim: dump.vcd
	gtkwave dump.vcd


and_test: And_tb.v And.v Nand.v
	@iverilog -o And_test.out And_tb.v And.v Nand.v
	@vvp And_test.out
	@diff --strip-trailing-cr And.out And.cmp
	@echo "--- AND PASS ---"

and16_test: And16_tb.v And16.v Nand.v
	@iverilog -o And16_test.out And16_tb.v And16.v Nand.v
	@vvp And16_test.out
	@diff --strip-trailing-cr And16.out And16.cmp
	@echo "--- AND16 PASS ---"

mux_test: Mux_tb.v Mux.v 
	@iverilog -o Mux_test.out Mux_tb.v Mux.v 
	@vvp Mux_test.out
	@diff --strip-trailing-cr Mux.out Mux.cmp
	@echo "--- MUX PASS ---"

mux16_test: Mux16_tb.v Mux16.v 
	@iverilog -o Mux16_test.out Mux16_tb.v Mux16.v 
	@vvp Mux16_test.out
	@diff --strip-trailing-cr Mux16.out Mux16.cmp
	@echo "--- MUX16 PASS ---"

nand_test: Nand_tb.v Nand.v
	@iverilog -o Nand_test.out Nand_tb.v Nand.v
	@vvp Nand_test.out
	@diff --strip-trailing-cr Nand.out Nand.cmp
	@echo "--- NAND PASS ---"

not_test: Not_tb.v Not.v Nand.v
	@iverilog -o Not_test.out Not_tb.v Not.v Nand.v
	@vvp Not_test.out
	@diff --strip-trailing-cr Not.out Not.cmp
	@echo "--- NOT PASS ---"

not16_test: Not16_tb.v Not16.v Nand.v
	@iverilog -o Not16_test.out Not16_tb.v Not16.v Nand.v
	@vvp Not16_test.out
	@diff --strip-trailing-cr Not16.out Not16.cmp
	@echo "--- NOT16 PASS ---"

or_test: Or_tb.v Or.v Not.v Nand.v
	@iverilog -o Or_test.out Or_tb.v  Or.v Not.v Nand.v
	@vvp Or_test.out
	@diff --strip-trailing-cr Or.out Or.cmp
	@echo "--- OR PASS ---"

or8_test: Or8Way_tb.v Or8Way.v 
	@iverilog -o Or8_test.out Or8Way_tb.v Or8Way.v
	@vvp Or8_test.out
	@diff --strip-trailing-cr Or8Way.out Or8Way.cmp
	@echo "--- OR8 PASS ---"

or16_test: Or16_tb.v Or16.v 
	@iverilog -o Or16_test.out Or16_tb.v Or16.v
	@vvp Or16_test.out
	@diff --strip-trailing-cr Or16.out Or16.cmp
	@echo "--- OR16 PASS ---"

xor_test: Xor_tb.v Xor.v Not.v And.v Or.v Nand.v
	@iverilog -o Xor_test.out Xor_tb.v Xor.v Not.v And.v Or.v Nand.v
	@vvp Xor_test.out
	@diff --strip-trailing-cr Xor.out Xor.cmp
	@echo "--- XOR PASS ---"

Mux8Way16_test: Mux8Way16_tb.v Mux8Way16.v
	@iverilog -o Mux8Way16_test.out Mux8Way16_tb.v Mux8Way16.v
	@vvp Mux8Way16_test.out
	@diff --strip-trailing-cr Mux8Way16.out Mux8Way16.cmp
	@echo "-- Mux8Way16 PASS --"

DMux4Way: DMux4Way_tb.v DMux4Way.v
	@iverilog -o DMux4Way_test.out DMux4Way_tb.v DMux4Way.v
	@vvp DMux4Way_test.out
	@diff --strip-trailing-cr DMux4Way.out DMux4Way.cmp
	@echo "-- DMux4Way PASS --"

DMux8Way: DMux8Way_tb.v DMux8Way.v
	@iverilog -o DMux8Way_test.out DMux8Way_tb.v DMux8Way.v
	@vvp DMux8Way_test.out
	@diff --strip-trailing-cr DMux8Way.out DMux8Way.cmp
	@echo "-- DMux8Way PASS --"

DMux: DMux_tb.v DMux.v
	@iverilog -o DMux_test.out DMux_tb.v DMux.v
	@vvp DMux_test.out
	@diff --strip-trailing-cr DMux.out DMux.cmp
	@echo "-- DMux PASS --"

test: and_test and16_test mux_test mux16_test nand_test not_test not16_test or_test or8_test or16_test xor_test Mux8Way16_test DMux8Way DMux
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out
