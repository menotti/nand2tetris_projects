SRC = RAM512.v RAM512_tb.v ../a/RAM64.v ../a/RAM8.v ../a/Bit.v ../a/Register.v ../../01/DMux8Way.v ../../01/Mux8Way16.v ../a/RegisterRAM8.v
all test.out: 
	iverilog -g2012 -o test.out *.v

run dump.vcd: test.out
	vvp test.out

sim: dump.vcd
	gtkwave dump.vcd



RAM512_test: $(SRC)
	@iverilog -g2012 -o RAM512_test.out $(SRC)
	@vvp RAM512_test.out
	@diff --strip-trailing-cr RAM512.out RAM512.cmp
	@echo "--- RAM512 PASS ---"

test: RAM512_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out

cmp2tv: ../../cmp2tv.py
	@python3 ../../cmp2tv.py $(FILE)

cmp2tvWclk: ../../cmp2tvWclk.py
	@python3 ../../cmp2tvWclk.py $(FILE)
