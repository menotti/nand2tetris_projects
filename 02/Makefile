all test.out: 
	iverilog -o test.out *.v

run dump.vcd: test.out
	vvp test.out

sim: dump.vcd
	gtkwave dump.vcd


Inc16_test: Inc16_tb.v Inc16.v Add16.v FullAdder.v HalfAdder.v
	@iverilog -o Inc16_test.out Inc16_tb.v Inc16.v Add16.v FullAdder.v HalfAdder.v 
	@vvp Inc16_test.out
	@diff --strip-trailing-cr Inc16.out Inc16.cmp
	@echo "--- Inc16 PASS ---"

test: Inc16_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out
