SRC = RAM16K.v RAM16K_tb.v RAM4K.v RAM4K_tb.v RAM512.v RAM512_tb.v ../a/RAM64.v ../a/RAM8.v ../a/Bit.v ../a/Register.v ../../01/DMux8Way.v ../../01/DMux4Way.v ../../01/Mux8Way16.v ../../01/Mux4Way16.v  ../a/RegisterRAM8.v 
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

RAM4K_test: $(SRC)
	@iverilog -g2012 -o RAM4K_test.out $(SRC)
	@vvp RAM4K_test.out
	@diff --strip-trailing-cr RAM4K.out RAM4K.cmp
	@echo "--- RAM4K PASS ---"

RAM16K_test: $(SRC)
	@iverilog -g2012 -o RAM16K_test.out $(SRC)
	@vvp RAM16K_test.out
	@diff --strip-trailing-cr RAM16K.out RAM16K.cmp
	@echo "--- RAM16K PASS ---"

test: RAM512_test RAM4K_test RAM16K_test
	@echo ""
	@echo "--- ALL PASS ---\n"

clean:
	rm -f *.vcd *.out

cmp2tv: ../../cmp2tv.py
	@python3 ../../cmp2tv.py $(FILE)

cmp2tvWclk: ../../cmp2tvWclk.py
	@python3 ../../cmp2tvWclk.py $(FILE)
