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

Add16_test: Add16_tb.v Add16.v FullAdder.v HalfAdder.v
	@iverilog -o Add16_test.out Add16_tb.v Add16.v FullAdder.v HalfAdder.v 
	@vvp Add16_test.out
	@diff --strip-trailing-cr Add16.out Add16.cmp
	@echo "--- Add16 PASS ---"

FullAdder_test: FullAdder_tb.v FullAdder.v HalfAdder.v
	@iverilog -o FullAdder_test.out FullAdder_tb.v FullAdder.v HalfAdder.v 
	@vvp FullAdder_test.out
	@diff --strip-trailing-cr FullAdder.out FullAdder.cmp
	@echo "--- FullAdder PASS ---"

HalfAdder_test: HalfAdder_tb.v HalfAdder.v 
	@iverilog -o HalfAdder_test.out HalfAdder_tb.v HalfAdder.v
	@vvp HalfAdder_test.out
	@diff --strip-trailing-cr HalfAdder.out HalfAdder.cmp
	@echo "--- HalfAdder PASS ---"

ALU_test: ALU_tb.v ALU.v 
	@iverilog -o ALU_test.out ALU_tb.v ALU.v
	@vvp ALU_test.out
	@diff --strip-trailing-cr ALU.out ALU.cmp
	@echo "--- ALU PASS ---"

ALU-nostat_test: ALU-nostat_tb.v ALU-nostat.v 
	@iverilog -o ALU-nostat_test.out ALU-nostat_tb.v ALU-nostat.v
	@vvp ALU-nostat_test.out
	@diff --strip-trailing-cr ALU-nostat.out ALU-nostat.cmp
	@echo "--- ALU-nostat PASS ---"

test: Inc16_test Add16_test FullAdder_test HalfAdder_test ALU_test ALU-nostat_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out
