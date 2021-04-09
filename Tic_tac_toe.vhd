-- Quartus II VHDL Template
-- Basic Shift Register

library ieee;
use ieee.numeric_bit.all;

entity final is
	-- x is always first
	port 
	(
		clk : in bit;
		reset : in bit;
		
		
		pb00, pb01, pb02	: in bit := '0'; --pb
		pb10, pb11, pb12	: in bit := '0';
		pb20, pb21, pb22	: in bit := '0';
		
		r00, r01, r02	: out bit := '0';  --red(x) light control
		r10, r11, r12	: out bit := '0';
		r20, r21, r22	: out bit := '0';
		
		g00, g01, g02	: out bit := '0';  --green(o) light control
		g10, g11, g12	: out bit := '0';
		g20, g21, g22	: out bit := '0';
		
		--ppp00, ppp01, ppp02	: out bit := '0';
		--ppp10, ppp11, ppp12	: out bit := '0';
		--ppp20, ppp21, ppp22	: out bit := '0';
		first : in bit := '0'; --'0':computer first '1':player first
		tuuurn : out boolean;
		testsum : out integer range 0 to 9 := 0;
		ll6, ll8 : out integer range 0 to 9 := 0;
		win : out bit;
		lose : out bit
	);

end entity;

architecture ttt of final is
type a33 is array (0 to 2) of unsigned(0 to 2);

signal p : a33 := ("000",  --'0'not occupied
						 "000",
						 "000");
signal rr : a33 := ("000",  --red(x) light control
						  "000",
						  "000");
signal rg : a33 := ("000",  --green(o) light control
						  "000",
						  "000");
signal turn : boolean := TRUE;  --TRUE player's turn
signal State,nextstate: integer range 0 to 7 := 0;
signal www : bit := '0';
signal lll : bit := '0';
signal do00, do01, do02 : boolean := False;
signal do10, do11, do12 : boolean := False;
signal do20, do21, do22 : boolean := False;
signal DO : boolean := False;
begin
	
	tuuurn <= turn;
	p(0)(0) <= rr(0)(0) or rg(0)(0); p(0)(1) <= rr(0)(1) or rg(0)(1); p(0)(2) <= rr(0)(2) or rg(0)(2);
	p(1)(0) <= rr(1)(0) or rg(1)(0); p(1)(1) <= rr(1)(1) or rg(1)(1); p(1)(2) <= rr(1)(2) or rg(1)(2);
	p(2)(0) <= rr(2)(0) or rg(2)(0); p(2)(1) <= rr(2)(1) or rg(2)(1); p(2)(2) <= rr(2)(2) or rg(2)(2);
	--ppp00 <= p00; ppp01 <= p01; ppp02 <= p02;
	--ppp10 <= p10; ppp11 <= p11; ppp12 <= p12;
	--ppp20 <= p20; ppp21 <= p21; ppp22 <= p22;
	r00 <= rr(0)(0); r01 <= rr(0)(1); r02 <= rr(0)(2);
	r10 <= rr(1)(0); r11 <= rr(1)(1); r12 <= rr(1)(2);
	r20 <= rr(2)(0); r21 <= rr(2)(1); r22 <= rr(2)(2);	
	g00 <= rg(0)(0); g01 <= rg(0)(1); g02 <= rg(0)(2);
	g10 <= rg(1)(0); g11 <= rg(1)(1); g12 <= rg(1)(2);
	g20 <= rg(2)(0); g21 <= rg(2)(1); g22 <= rg(2)(2);	
	
	DO <= do00 or do01 or do02 or do10 or do11 or do12 or do20 or do21 or do22;
	
	process(www, lll)
	begin
		if clk'event and clk = '1' then
			win <= www; --win: '0'computer wins '1'player wins
			lose <= lll;
			
		end if;
	end process;
	
	
	process(State, clk, first, reset, turn)
	variable i : integer := 0; 
	variable j : integer := 0; 
	variable step : boolean := False; 
	variable l1, l2, l3, l4, l5, l6, l7, l8 : integer range 0 to 9 := 0;
	
	
	
	
	begin
		if first='0' then
			if clk'event and clk = '1' then
				case State is
					--********************************************************************--
					when 0=>  nextstate<=1; rr(2)(0)<='1'; turn <= True;  --computer's first step
					--********************************************************************--
					when 1=> --player's turn
								
								if pb00='1' and p(0)(0) = '0' then
									nextstate <= 6;
									rg(0)(0) <= '1';
									turn <= False;
								elsif pb01='1' and p(0)(1) = '0' then
									nextstate <= 6;
									rg(0)(1) <= '1';
									turn <= False;
								elsif pb02='1' and p(0)(2) = '0' then
									nextstate <= 6;
									rg(0)(2) <= '1';
									turn <= False;
								elsif pb10='1' and p(1)(0) = '0' then
									nextstate <= 6;
									rg(1)(0) <= '1';
									turn <= False;
								elsif pb11='1' and p(1)(1) = '0' then
									nextstate <= 6;
									rg(1)(1) <= '1';
									turn <= False;
								elsif pb12='1' and p(1)(2) = '0' then
									nextstate <= 6;
									rg(1)(2) <= '1';
									turn <= False;
								elsif pb20='1' and p(2)(0) = '0' then
									nextstate <= 6;
									rg(2)(0) <= '1';
									turn <= False;
								elsif pb21='1' and p(2)(1) = '0' then
									nextstate <= 6;
									rg(2)(1) <= '1';
									turn <= False;
								elsif pb22='1' and p(2)(2) = '0' then
									nextstate <= 6;
									rg(2)(2) <= '1';
									turn <= False;								
								end if;

					--********************************************************************-- 
					when 2=> if turn = False then
									
									if p(1)(1)='1' then rr(0)(0)<='1';--computer's second step
									elsif ((p(0)(0) or p(0)(1) or p(0)(2) or p(1)(0)) = '1') then rr(2)(2)<='1'; 
									elsif ((p(1)(2) or p(2)(1) or p(2)(2)) = '1') then rr(0)(0)<='1'; 
									end if;
								end if;
								nextstate <= 1;
								turn <= True;
								step := True;
								
					--********************************************************************--
					when 3=> if (rr(0)="100" and p(0)(1)='0' and p(0)(2)='0')
								or (rr(0)="010" and p(0)(0)='0' and p(0)(2)='0')
								or (rr(0)="001" and p(0)(0)='0' and p(0)(1)='0') then l1 := 1; 
								else l1 := 0; end if;
								if (rr(1)="100" and p(1)(1)='0' and p(1)(2)='0')
								or (rr(1)="010" and p(1)(0)='0' and p(1)(2)='0')
								or (rr(1)="001" and p(1)(0)='0' and p(1)(1)='0') then l2 := 1;
								else l2 := 0; end if;
								if (rr(2)="100" and p(2)(1)='0' and p(2)(2)='0')
								or (rr(2)="010" and p(2)(0)='0' and p(2)(2)='0')
								or (rr(2)="001" and p(2)(0)='0' and p(2)(1)='0') then l3 := 1; 
								else l3 := 0; end if;
								
								
								if (rr(0)(0)='1' and rr(1)(0)='0' and rr(2)(0)='0' and p(1)(0)='0' and p(2)(0)='0')
								or (rr(0)(0)='0' and rr(1)(0)='1' and rr(2)(0)='0' and p(0)(0)='0' and p(2)(0)='0')
								or (rr(0)(0)='0' and rr(1)(0)='0' and rr(2)(0)='1' and p(0)(0)='0' and p(1)(0)='0') then l4 := 1;
								else l4 := 0; end if;
								if (rr(0)(1)='1' and rr(1)(1)='0' and rr(2)(1)='0' and p(1)(1)='0' and p(2)(1)='0')
								or (rr(0)(1)='0' and rr(1)(1)='1' and rr(2)(1)='0' and p(0)(1)='0' and p(2)(1)='0')
								or (rr(0)(1)='0' and rr(1)(1)='0' and rr(2)(1)='1' and p(0)(1)='0' and p(1)(1)='0') then l5 := 1;
								else l5 := 0; end if;
								if (rr(0)(2)='1' and rr(1)(2)='0' and rr(2)(2)='0' and p(1)(2)='0' and p(2)(2)='0')
								or (rr(0)(2)='0' and rr(1)(2)='1' and rr(2)(2)='0' and p(0)(2)='0' and p(2)(2)='0')
								or (rr(0)(2)='0' and rr(1)(2)='0' and rr(2)(2)='1' and p(0)(2)='0' and p(1)(2)='0') then l6 := 1;
								else l6 := 0; end if;
								
								
								
								if (rr(0)(0)='1' and rr(1)(1)='0' and rr(2)(2)='0' and p(1)(1)='0' and p(2)(2)='0')
								or (rr(0)(0)='0' and rr(1)(1)='1' and rr(2)(2)='0' and p(0)(0)='0' and p(2)(2)='0')
								or (rr(0)(0)='0' and rr(1)(1)='0' and rr(2)(2)='1' and p(0)(0)='0' and p(1)(1)='0') then l7 := 1;
								else l7 := 0; end if;
								if (rr(2)(0)='1' and rr(1)(1)='0' and rr(0)(2)='0' and p(1)(1)='0' and p(0)(2)='0')
								or (rr(2)(0)='0' and rr(1)(1)='1' and rr(0)(2)='0' and p(2)(0)='0' and p(0)(2)='0')
								or (rr(2)(0)='0' and rr(1)(1)='0' and rr(0)(2)='1' and p(2)(0)='0' and p(1)(1)='0') then l8 := 1;
								else l8 := 0; end if;
								testsum <= l1+l6+l8;
								ll6 <= l6;
								ll8 <= l8;
								nextstate <= 7;
					------------------------------------------------------------------------------------------------------------
								
					when 7=>	if not turn then 
									---------------------------------------------------------------------
									---------------------------------------------------------------------
									--to attack
									--- -
									if rr(0)="011" and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif rr(0)="101" and p(0)(1)='0' then nextstate <= 5; turn <= True; rr(0)(1) <= '1';
									elsif rr(0)="110" and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';
									elsif rr(1)="011" and p(1)(0)='0' then nextstate <= 5; turn <= True; rr(1)(0) <= '1';
									elsif rr(1)="101" and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif rr(1)="110" and p(1)(2)='0' then nextstate <= 5; turn <= True; rr(1)(2) <= '1';
									elsif rr(2)="011" and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif rr(2)="101" and p(2)(1)='0' then nextstate <= 5; turn <= True; rr(2)(1) <= '1';
									elsif rr(2)="110" and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';										
									--- |	
									elsif (rr(0)(0)='0' and rr(1)(0)='1' and rr(2)(0)='1') and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif (rr(0)(0)='1' and rr(1)(0)='0' and rr(2)(0)='1') and p(1)(0)='0' then nextstate <= 5; turn <= True; rr(1)(0) <= '1';
									elsif (rr(0)(0)='1' and rr(1)(0)='1' and rr(2)(0)='0') and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif (rr(0)(1)='0' and rr(1)(1)='1' and rr(2)(1)='1') and p(0)(1)='0' then nextstate <= 5; turn <= True; rr(0)(1) <= '1';
									elsif (rr(0)(1)='1' and rr(1)(1)='0' and rr(2)(1)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rr(0)(1)='1' and rr(1)(1)='1' and rr(2)(1)='0') and p(2)(1)='0' then nextstate <= 5; turn <= True; rr(2)(1) <= '1';
									elsif (rr(0)(2)='0' and rr(1)(2)='1' and rr(2)(2)='1') and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';
									elsif (rr(0)(2)='1' and rr(1)(2)='0' and rr(2)(2)='1') and p(1)(2)='0' then nextstate <= 5; turn <= True; rr(1)(2) <= '1';
									elsif (rr(0)(2)='1' and rr(1)(2)='1' and rr(2)(2)='0') and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';					
									--- \	
									elsif (rr(0)(0)='0' and rr(1)(1)='1' and rr(2)(2)='1') and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif (rr(0)(0)='1' and rr(1)(1)='0' and rr(2)(2)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rr(0)(0)='1' and rr(1)(1)='1' and rr(2)(2)='0') and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';
									--- /
									elsif (rr(2)(0)='0' and rr(1)(1)='1' and rr(0)(2)='1') and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif (rr(2)(0)='1' and rr(1)(1)='0' and rr(0)(2)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rr(2)(0)='1' and rr(1)(1)='1' and rr(0)(2)='0') and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';

									
									---------------------------------------------------------------------
									---------------------------------------------------------------------
									--to defend
									--- -
									elsif rg(0)="011" and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif rg(0)="101" and p(0)(1)='0' then nextstate <= 5; turn <= True; rr(0)(1) <= '1';
									elsif rg(0)="110" and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';
									elsif rg(1)="011" and p(1)(0)='0' then nextstate <= 5; turn <= True; rr(1)(0) <= '1';
									elsif rg(1)="101" and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif rg(1)="110" and p(1)(2)='0' then nextstate <= 5; turn <= True; rr(1)(2) <= '1';
									elsif rg(2)="011" and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif rg(2)="101" and p(2)(1)='0' then nextstate <= 5; turn <= True; rr(2)(1) <= '1';
									elsif rg(2)="110" and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';										
									--- |	
									elsif (rg(0)(0)='0' and rg(1)(0)='1' and rg(2)(0)='1') and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif (rg(0)(0)='1' and rg(1)(0)='0' and rg(2)(0)='1') and p(1)(0)='0' then nextstate <= 5; turn <= True; rr(1)(0) <= '1';
									elsif (rg(0)(0)='1' and rg(1)(0)='1' and rg(2)(0)='0') and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif (rg(0)(1)='0' and rg(1)(1)='1' and rg(2)(1)='1') and p(0)(1)='0' then nextstate <= 5; turn <= True; rr(0)(1) <= '1';
									elsif (rg(0)(1)='1' and rg(1)(1)='0' and rg(2)(1)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rg(0)(1)='1' and rg(1)(1)='1' and rg(2)(1)='0') and p(2)(1)='0' then nextstate <= 5; turn <= True; rr(2)(1) <= '1';
									elsif (rg(0)(2)='0' and rg(1)(2)='1' and rg(2)(2)='1') and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';
									elsif (rg(0)(2)='1' and rg(1)(2)='0' and rg(2)(2)='1') and p(1)(2)='0' then nextstate <= 5; turn <= True; rr(1)(2) <= '1';
									elsif (rg(0)(2)='1' and rg(1)(2)='1' and rg(2)(2)='0') and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';																		
									--- \	
									elsif (rg(0)(0)='0' and rg(1)(1)='1' and rg(2)(2)='1') and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1';
									elsif (rg(0)(0)='1' and rg(1)(1)='0' and rg(2)(2)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rg(0)(0)='1' and rg(1)(1)='1' and rg(2)(2)='0') and p(2)(2)='0' then nextstate <= 5; turn <= True; rr(2)(2) <= '1';
									--- /	
									elsif (rg(2)(0)='0' and rg(1)(1)='1' and rg(0)(2)='1') and p(2)(0)='0' then nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif (rg(2)(0)='1' and rg(1)(1)='0' and rg(0)(2)='1') and p(1)(1)='0' then nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (rg(2)(0)='1' and rg(1)(1)='1' and rg(0)(2)='0') and p(0)(2)='0' then nextstate <= 5; turn <= True; rr(0)(2) <= '1';
										
									---------------------------------------------------------------------
									---------------------------------------------------------------------
									--for best position
									elsif (l1+l4+l7)>1 and p(0)(0)='0' then nextstate <= 5; turn <= True; rr(0)(0) <= '1'; --nextstate <= 5; turn <= True; 
									elsif (l1+l5)>1 and p(0)(1)='0' then nextstate <= 5; turn <= True; rr(0)(1) <= '1';
									elsif (l1+l6+l8)>1 and p(0)(2)='0' then  nextstate <= 5; turn <= True; rr(0)(2) <= '1';
									elsif (l2+l4)>1 and p(1)(0)='0' then  nextstate <= 5; turn <= True; rr(1)(0) <= '1';
									elsif (l2+l5+l7+l8)>1 and p(1)(1)='0' then  nextstate <= 5; turn <= True; rr(1)(1) <= '1';
									elsif (l2+l6)>1 and p(1)(2)='0' then  nextstate <= 5; turn <= True; rr(1)(2) <= '1';
									elsif (l3+l4+l8)>1 and p(2)(0)='0' then  nextstate <= 5; turn <= True; rr(2)(0) <= '1';
									elsif (l3+l5)>1 and p(2)(1)='0' then  nextstate <= 5; turn <= True; rr(2)(1) <= '1';
									elsif (l3+l6+l7)>1 and p(2)(2)='0' then  nextstate <= 5; turn <= True; rr(2)(2) <= '1';
									
									---------------------------------------------------------------------
									---------------------------------------------------------------------
									--arbitrary
									elsif (p(0)(0)='0') then nextstate <= 5; turn<=true; rr(0)(0) <= '1'; 
									elsif (p(0)(1)='0') then nextstate <= 5; turn<=true; rr(0)(1) <= '1'; 
									elsif (p(0)(2)='0') then nextstate <= 5; turn<=true; rr(0)(2) <= '1'; 
									
									elsif (p(1)(0)='0') then nextstate <= 5; turn<=true; rr(1)(0) <= '1'; 
									elsif (p(1)(1)='0') then nextstate <= 5; turn<=true; rr(1)(1) <= '1'; 
									elsif (p(1)(2)='0') then nextstate <= 5; turn<=true; rr(1)(2) <= '1'; 
									
									elsif (p(2)(0)='0') then nextstate <= 5; turn<=true; rr(2)(0) <= '1'; 
									elsif (p(2)(1)='0') then nextstate <= 5; turn<=true; rr(2)(1) <= '1'; 
									elsif (p(2)(2)='0') then nextstate <= 5; turn<=true; rr(2)(2) <= '1'; 
									else nextstate <= 4;
									end if;	
								end if;
								
								
				
					--********************************************************************--
								
								
					when 4=> if reset = '1' then
									--reset all variable and signal
									rr(0)(0)<='0';rr(0)(1)<='0';rr(0)(2)<='0';
									rr(1)(0)<='0';rr(1)(1)<='0';rr(1)(2)<='0';
									rr(2)(0)<='0';rr(2)(1)<='0';rr(2)(2)<='0';
									rg(0)(0)<='0';rg(0)(1)<='0';rg(0)(2)<='0';
									rg(1)(0)<='0';rg(1)(1)<='0';rg(1)(2)<='0';
									rg(2)(0)<='0';rg(2)(1)<='0';rg(2)(2)<='0';
									turn <= TRUE;  

									www <= '0';
									lll <= '0';
									do00 <=False; do01 <=False; do02 <=False;
									do10 <=False; do11 <=False; do12 <=False;
									do20 <=False; do21 <=False; do22 <=False;
									nextstate <= 0;
								end if;
					
					when 5=> if rr(0)="111" or rr(1)="111" or rr(2)="111"
									or (rr(0)(0)='1' and rr(1)(0)='1' and rr(2)(0)='1')
									or (rr(0)(1)='1' and rr(1)(1)='1' and rr(2)(1)='1')
									or (rr(0)(2)='1' and rr(1)(2)='1' and rr(2)(2)='1')
									or (rr(0)(0)='1' and rr(1)(1)='1' and rr(2)(2)='1')
									or (rr(2)(0)='1' and rr(1)(1)='1' and rr(0)(2)='1')  then nextstate<=4; lll<='1';
								elsif p(0)&p(1)&p(2) ="111111111" then nextstate<=4; lll<='1'; www<='1';
								else nextstate<=1;
								end if;
					
					when 6=>if (rg(0)="111" or rg(1)="111" or rg(2)="111"
									or (rg(0)(0)='1' and rg(1)(0)='1' and rg(2)(0)='1')
									or (rg(0)(1)='1' and rg(1)(1)='1' and rg(2)(1)='1')
									or (rg(0)(2)='1' and rg(1)(2)='1' and rg(2)(2)='1')
									or (rg(0)(0)='1' and rg(1)(1)='1' and rg(2)(2)='1')
									or (rg(2)(0)='1' and rg(1)(1)='1' and rg(0)(2)='1'))  then nextstate<=4; www<='1';
								elsif p(0)&p(1)&p(2) ="111111111" then nextstate<=4; lll<='1'; www<='1';
								else  
									if step then
										nextstate <= 3;
									else nextstate <= 2;
									end if;
								end if;
				end case;
			end if;
		end if;
	end process;
	
	process(clk)
	begin
	  if clk'event and clk = '1' then
			State <= nextstate;
	  end if;
	end process;

end architecture;
