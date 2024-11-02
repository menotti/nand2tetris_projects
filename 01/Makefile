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

test: and_test and16_test mux_test mux16_test nand_test not_test not16_test or_test or16_test xor_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out