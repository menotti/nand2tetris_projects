all test.out: 
	iverilog -g2012 -o test.out *.v

run dump.vcd: test.out
	vvp test.out

sim: dump.vcd
	gtkwave dump.vcd

Bit_test: Bit_tb.v Bit.v 
	@iverilog -g2012 -o Bit_test.out Bit_tb.v Bit.v
	@vvp Bit_test.out
	@diff --strip-trailing-cr Bit.out Bit.cmp
	@echo "--- Bit PASS ---"

test: Bit_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out
