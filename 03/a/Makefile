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

Register_test: Register_tb.v Register.v 
	@iverilog -g2012 -o Register_test.out Register_tb.v Register.v
	@vvp Register_test.out
	@diff --strip-trailing-cr Register.out Register.cmp
	@echo "--- Register PASS ---"

PC_test: PC_tb.v PC.v 
	@iverilog -g2012 -o PC_test.out PC_tb.v PC.v
	@vvp PC_test.out
	@diff --strip-trailing-cr PC.out PC.cmp
	@echo "--- PC PASS ---"

test: Bit_test Register_test PC_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out
