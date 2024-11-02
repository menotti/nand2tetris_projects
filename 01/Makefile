all Xor_test.out: Xor_tb.v Xor.v Or.v Not.v And.v Nand.v
	iverilog -o Xor_test.out Xor_tb.v Xor.v Or.v Not.v And.v Nand.v

run Xor_tb.vcd: Xor_test.out
	vvp Xor_test.out

sim: Xor_tb.vcd
	gtkwave Xor_tb.vcd

nand_test: Nand_tb.v Nand.v
	@iverilog -o Nand_test.out Nand_tb.v Nand.v
	@vvp Nand_test.out
	@diff Nand.out Nand.cmp
	@echo "--- NAND PASS ---"

not_test: Not_tb.v Not.v Nand.v
	@iverilog -o Not_test.out Not_tb.v Not.v Nand.v
	@vvp Not_test.out
	@diff Not.out Not.cmp
	@echo "--- Not PASS ---"

and_test: And_tb.v And.v Nand.v
	@iverilog -o And_test.out And_tb.v And.v Nand.v
	@vvp And_test.out
	@diff And.out And.cmp
	@echo "--- AND PASS ---"

or_test: Or_tb.v Or.v Not.v Nand.v
	@iverilog -o Or_test.out Or_tb.v  Or.v Not.v Nand.v
	@vvp Or_test.out
	@diff Or.out Or.cmp
	@echo "--- OR PASS ---"

xor_test: Xor_tb.v Xor.v Not.v And.v Or.v Nand.v
	@iverilog -o Xor_test.out Xor_tb.v Xor.v Not.v And.v Or.v Nand.v
	@vvp Xor_test.out
	@diff Xor.out Xor.cmp
	@echo "--- XOR PASS ---"

test: nand_test not_test and_test or_test xor_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out