library bitlib;
use bitlib.bit_pack.all

entity dicegame is
	port(rb,reset,clk:in bit; sum:int integer range 2 to 12; roll,win,lose:out bit);
end dicegame;

architecture adicegame of dicegame is
	signal state, nextstate:integer range 0 to 5;
	signal point:integer range 2 to 12;
	signal sp:bit;
begin
process(rb,reset,simstate)
	begin
		sp<='0';roll<='0';win='0';lose<='0';
		case state is
			when  0=> if rb='1' then nextstate<=1;end if;
			when 1=>
				if rb='1' then roll<='1';
					elsif sum=7 or sum=11 then nexstate <=2;
					elsif sum=2 or sum=3 or sum=12 then nextstate<=3;
					elsif sp<='1';nextstate<=4;
				end if;
			when 2=>win<='1';
				if reset='1' then nextstate<=0;end if;
			when 3=>lose<='1';
				if reset='1' then nextstate<=0;end if;
			when 4=>if rb='1' then nextstate<=5;end if;
			when 5=>
				if rb='1' then roll<='1';
					elsif sum=point then nextstate<=2;
					elsif sum=7 then nextstate<=3;
					else nextstate<=4;
				end if;
		end case;
end process;

process(clk)
	begin
		if rising_edge(clk) then
			state<=nextstatel
			if sp='1' then point<=sum;end if;
		end if;
end process;
end adicegame;

--Счетчик

entity counter is
	port(clk,roll:in bit;sum:out integer 2 to 12);
end counter

architecture count of counter is
	signal cnt1,cnt2:integer range 1 to 6:=1;
begin
process(clk)
begin
	if clk'event and clk='1' then
		if roll='1' then
			if cnt1=6 then cnt1<=1;
			else cnt1<=cnt1+1;
			end if;
			if cnt1=6 then
				if cnt2=6 then cnt2<=1;
				else cnt2<=cnt2+1;
				end if;
			end if;
		end if;
	end if;
end process;

sim<=cnt1+cnt2;
end count;

--Модуль для игры в кости

entity game is
	port(rb,reset,clk:in bit;win,lose:out bit);
end game;

architecture play1 of game is
component counter
	port(clk,roll:in bit;sum:out integer range 2 to 12);
end component
component dice game
	port(rb,reset,clk:in bit; sum:int integer range 2 to 12; roll,win,lose:out bit);
end component;

signal roll1:bit;
signal sum1:integer range 2 to 12;
begin
	dice:dicegame port map(rb,reset,clk,sum1,roll1,win,lose);
	count:counter port map(clk,roll1,sum1);
end play1;
