pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
-- frogsgame
-- by mwolf and yvonnedo69

k=1 --keroppi position
f=0 --left foot 0, right foot 1
c=0 --casting 0 no 1 yes
h=0 --bobber pos, hor/vert
v=0

b=0 --bobber bob

w=0 --watermove
y=0

fp=75 + rnd(35) --fish position
fs=41 -- fish sprite/direction 41 is left, 42 is right
fp2=80 + rnd(30) --fish2 position
fs2=42 -- fish2 sprite/direction 41 is left, 42 is right
fp3=80 + rnd(30) --fish position
fs3=57 -- fish sprite/direction 57 is left, 58 is right

fpx=80 --frog position
fpy=105
fpdx=0 --frog direction
fpdy=0
fspr=0 --frog sprite
caught=0

function draw_keroppi(x)

	if (c==0) then 	--body
		caught=0
		h=5000
		v=5000
		sspr(56,0,24,16,x,44)
		spr(10,x+8,36)
	elseif (c<15) then --momentary panic
		sspr(88,0,24,16,x,44)
		spr(26,x+23,39)
		cast()
	else --back to normal
		sspr(112,8,16.8,8,x,44)
		spr(13,x+16,44)
		spr(26,x+23,39)
		spr(23,x,52)
		spr(24,x+8,52)
		spr(29,x+16,52)
		cast()
	end

	if (f==0) then --feet
		sspr(56,16,16,8,x,60)
	else
		sspr(56,24,16,8,x,60)
	end
	move_water()
end

function cast()
	if caught == 1 then
		 if v > -20 then
			v = v-2
		    fpy = fpy -2
			if h < k+8 then
			   h=h-1
			   fpx=fpx-1
			end

		 end
	end
	if (b==0) then
		spr(18,k+25+h,67+v)
		line(k+31,43,k+29+h,68+v,6)
	else
		spr(19,k+25+h,67+v)
		line(k+31,43,k+29+h,69+v,6)
	end
	move_water()
end

function move_water()

	if (w - flr(w/9)*9==0) then --move fish1
		if (fs==41) then
			fp=fp-1
		else
			fp=fp+1
		end
	end

	if (w - flr(w/7)*7==0) then --move fish2
		if (fs2==41) then
			fp2=fp2-1
		else
			fp2=fp2+1
		end
	end

	if (w - flr(w/5)*5==0) then --move fish3
		if (fs3==57) then
			fp3=fp3-1
		else
			fp3=fp3+1
		end
	end

	if (w>75) then
		w=0
		if (y==0) then
			y=1
		else
			y=0
		end
	else
		w=w+1
	end
	-- lord forgive me for this water
	if (y==1) then
		mset(6,3,36)
		mset(7,3,37)
		mset(8,3,36)
		mset(9,3,37)
		mset(10,3,38)
		mset(11,3,36)
		mset(12,3,38)
		mset(13,3,36)
		mset(14,3,37)
		mset(15,3,38)
		mset(7,4,37)
		mset(8,4,51)
		mset(9,4,36)
		mset(10,4,36)
		mset(11,4,51)
		mset(12,4,37)
		mset(13,4,38)
		mset(14,4,36)
		mset(15,4,36)
		mset(8,5,51)
		mset(9,5,37)
		mset(10,5,36)
		mset(11,5,37)
		mset(12,5,38)
		mset(13,5,51)
		mset(14,5,36)
		mset(14,5,37)
	else
		mset(6,3,38)
		mset(7,3,36)
		mset(8,3,37)
		mset(9,3,38)
		mset(10,3,36)
		mset(11,3,37)
		mset(12,3,36)
		mset(13,3,37)
		mset(14,3,38)
		mset(15,3,38)
		mset(7,4,38)
		mset(8,4,36)
		mset(9,4,51)
		mset(10,4,38)
		mset(11,4,36)
		mset(12,4,36)
		mset(13,4,37)
		mset(14,4,36)
		mset(15,4,37)
		mset(8,5,36)
		mset(9,5,51)
		mset(10,5,37)
		mset(11,5,38)
		mset(12,5,36)
		mset(13,5,51)
		mset(14,5,37)
		mset(14,5,38)
	end
	palt(0, false)
	palt(1, true)

	--determine fish1 dir
	if (fp<62) then
		fs=42
	elseif (fp>130) then
		fs=41
	end
	spr(fs,fp,100)

	--determine fish2 dir
	if (fp2<67) then
		fs2=42
	elseif (fp2>130) then
		fs2=41
	end
	spr(fs2,fp2,115)

	--determine fish2 dir
	if (fp3<67) then
		fs3=58
	elseif (fp3>140) then
		fs3=57
	end
	spr(fs3,fp3,107)

	palt(1, false)
	palt(0, true)

	if (c>0) then
		if (c<15) then
			c = c+1
		end
	end
	draw_frog()
end

function draw_frog()


	--check catch
	if h+k+20 < fpx and fpx < h+k+30 and v+64< fpy and fpy < v+70 then
		print("you caught 'im!",
	      37, 80, 7)
		caught=1
	end

	if caught==0 then

		--going right
		if fpdx == 0 then
			if fpx < 120 then
				fpx = fpx + 0.15 + (1 * (121-fpx)/50)
			else
				fpdx = 1
			end
			--going left
		else
			if fpx > 60 then
				fpx = fpx - 0.15 - (1 * (fpx-59)/50)
			else
				fpdx = 0
			end
		end

		--going up
		if fpdy == 0 then
			if fpy < 110 then
				fpy = fpy + 0.15 + (1 * (121-fpx)/50)
			else
				fpdy =1
			end
		else
			if fpy > 70 then
				fpy = fpy - 0.15 - (1 * (fpx-59)/50)
			else
				fpdy =0
			end
		end

	end


	palt(0, false)
	palt(1, true)

	if fpdy == 0 then
		sspr(8,16.16,16,16,fpx,fpy)
	else
		sspr(8,16.16,16,16,fpx,fpy,16,16,true)
	end
	palt(0, true)
	palt(1, false)
end

function _draw()
	cls(12)

	map(0,0,0,48,16,10)

	print("you are keroppi",
	      34, 2, 7)
	print("press ❎ to cast",
	      32, 10, 7)

	draw_keroppi(k,0)

end

function _update()
	if (k - flr(k/9)*9==0) then
		if(f==0) then
			f=1
		else
			f=0
		end
	end

	--movement, only when not casting

	if (c==0) then
		--move left
		if (btn(0)) then
			if(k==1) then
				draw_keroppi(1)
			else
				k=k-1
				draw_keroppi(k)
			end
		end
		--move right
		if (btn(1)) then
			if(k==66) then
				draw_keroppi(66)
			else
				k=k+1
				draw_keroppi(k)
			end
		end
		--cast
		if k >18 then
			if (btnp(5)) then
				c=1
				if (f==1) then
					f=0
				else
					f=1
				end
				h=flr(rnd(30))
				v=flr(rnd(25))
				draw_keroppi(k)

			end
		end
	else
		--probably see if anything is caught

		--release
		if (btnp(5)) then
			c=0
			draw_keroppi(k)
		end
		if (flr(rnd(20)) > 18) then
			if (b==0) then
				b=1
			else
				b=0
			end
			cast()
		end
	end
end
__gfx__
00000000444044444044444404444440bbbbbbbbbbbbbbbbbbbbbbbb000000006000004000000000000400000000000000000000000000000400000000000000
0000000044404444404444440444444033333bbbbb333b333bbbbbbb000077760777004000000000006040000000777007770000000000004000000000000000
000000005555555555555555555555003344333bb3443333333b3333000777777777700400000000060040000007777777777000000000004000000000000000
00000000499445994445999944599940344444333444443443333344007777777777770400000000060040000077757777577700000000040000000000000000
00000000999995449995444499544440444444434444444444443444007775577557770400000000060004000077775775777700000000040000000000000000
000000009444409499909999940449b0444444444444444444444444007775577557770040000000600004000077757777577700000000400000000000000000
000000004444443b3b3b5555bb0033b344444444444444444444444403b7777777777b30400000006000040003b7777777777b30000000400000000000000000
000000004444444333334444b33333334444444444444444444444440bbb777bb777bbb040000000600000400bbb777bb777bbb0000004000000000000000000
000000000444444400000000000000004444444411111111411111110beebbbbbbbbeeb004000000000000000beebbb33bbbeeb0000004000000000000000000
000000000444444400000000000000004444444411111111441111110bbbbb3bb3bbbbb004000000000000000bbbbb3773bbbbb0000040000000777007770000
0000000055555555000880000000000044444444111111114441111100bbbbb33bbbbb00040000000000000000bbbb3773bbbb00000040000007777777777000
0000000049944599008888c0000880c0444444441111111144441111000bbbbbbbbbb0000447700000000000000bbbb33bbbb000004400000077777777777700
0000000099999549c077770cc088880c444444441111111144444111bbb8778877887bbbbb30000000000444bbb8778877887bbbbb3370000077755775577700
0000000094499094c066660cc066660c4444444411111111444444113b887788778878bbbbb00000000440003b887788778878bbbbbb07000077755775577700
000000000b0b3b3b0c0220c00c2222c0444444441111111144444441bb887788778878bbbb30000000400000bb887788778878bbbb30000003b7777777777b30
000000003b333b3300000000000110004444444411111111444444443b887788778878bb33400000040000003b887788778878bbb30000000bbb777bb777bbb0
00000000111331111111111141111111111111111111111111111111008b3b3b7788780011111111111111110000000004000000000000000000000000000000
0000000011133b111133111144cccc11cc111ccc11111111ccc11111008bbbbb778878001fffff1ff1fffff10000040404000040000000000000000000000000
000000001113551113031111444c111111ccc11111cccc11111ccccc000bbbbb0bbbbb00f09999ffff99990f0400040404004040000000000000000000000000
0000000011131113333331114444cc111111111ccc111111111111110000bbb003b3b300ffffff9ff9ffff9f0400040404004040000000000000000000000000
00000000531331138333331144444cc11111111111111111111111110000000000000000199999199199999104000b0b0b404040000000000000000000000000
0000000033113313033333334444441111cccc11111111111cccc1110000000000000000111111111111111104004b0b0b4040b0000000000000000000000000
00000000331113333033330344444441111111111111ccccc1111111000000000000000011111111111111110b004b0b0b40b0b0000000000000000000000000
00000000131113333300833344444441111111111111111111111111000000000000000011111111111111110b004b0b0bb0b0b0000000000000000000000000
00000000311133aa3333333111cccc1100040000000000000000000000887788b3b3b80011111116116111110b00bb0b0bb0b0b0000000000000000000000000
0000000031133aaaa3333351111111cc04040400000000000000000000887788bbbbb80011606661111666060b00bb0b0bb0b0b0000000000000000000000000
000000003113bbaaaa33113511111111040b04000000000000004040000bbbbbbbbbb00011666661111666660b0b0b0b0b0bb00b000000000000000000000000
000000003353bbaaa3333153111111110b3b0b0000000000000440400003b3b30bbb000011111116116111110b3b0b0b0b0bb00b000000000000000000000000
000000001335bbaa3331333311111cc10b3b3b3b330000000004b0b4000000000000000011111611611111110b3b3b3b3b0bb00b000000000000000000000000
00000000111bb33333111111111ccc110b3bbbbbbb333300033b33b4000000000000000060666111166606110b3bbbbbbb33330b000000000000000000000000
0000000011bb553311111111ccc111113bbb3b3bbbbb33333bbbb33b000000000000000066666111166666113bbb3b3bbbbb333b000000000000000000000000
0000000011b3333111111111111111113333333333333333333b333b000000000000000011111611611111113333333333333333000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc7c7cc77c7c7ccccc777c777c777ccccc7c7c777c777cc77c777c777c777ccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc7c7c7c7c7c7ccccc7c7c7c7c7ccccccc7c7c7ccc7c7c7c7c7c7c7c7cc7cccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc777c7c7c7c7ccccc777c77cc77cccccc77cc77cc77cc7c7c777c777cc7cccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc7c7c7c7c7ccccc7c7c7c7c7ccccccc7c7c7ccc7c7c7c7c7ccc7cccc7cccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc777c77ccc77ccccc7c7c7c7c777ccccc7c7c777c7c7c77cc7ccc7ccc777ccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc777c777c777cc77cc77cccccc77777cccccc777cc77cccccc77c777cc77c777ccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc7c7c7c7c7ccc7ccc7ccccccc77c7c77cccccc7cc7c7ccccc7ccc7c7c7cccc7cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc777c77cc77cc777c777ccccc777c777cccccc7cc7c7ccccc7ccc777c777cc7cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc7ccc7c7c7ccccc7ccc7ccccc77c7c77cccccc7cc7c7ccccc7ccc7c7ccc7cc7cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc7ccc7c7c777c77cc77ccccccc77777ccccccc7cc77ccccccc77c7c7c77ccc7cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc4446cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc44ccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccc777cc777ccccccccccccc4ccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc7777777777ccccccccccc4cccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc777577775777ccccccccc4ccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc777757757777ccccccccc4ccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc777577775777cccccccc4cccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc3b7777777777b3ccccccc4cccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccbbb777bb777bbbcccccc4ccccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccbeebbb33bbbeebcccccc4ccccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccbbbbb3773bbbbbccccc4cccccccccc6cccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccbbbb3773bbbbcccccc4ccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccbbbb33bbbbccccc44cccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccbbb8778877887bbbbb337ccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc3b887788778878bbbbbbc7cccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccbb887788778878bbbb3ccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc3b887788778878bbb3cccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc887788b3b3b8cccccccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc887788bbbbb8cccccccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccbbbbbbbbbbccccccccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc3b3b3cbbbcccccccccccccccccccc6ccccccccccccccccccccccccccccccccccccccccccccccc
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb444c4444c44444444c444444c44444444c444444c444444c6ccccccccccccccccccccccccccccccccccccccccccccccc
33333bbb3bbbbbbb33333bbbbb333b33444c4444c44444444c444444c44444444c444444c444444c6ccccccccccccccccccccccccccccccccccccccccccccccc
3344333b333b33333344333bb34433335555555555555555555555555555555555555555555555cc6ccccccccccccccccccccccccccccccccccccccccccccccc
344444334333334434444433344444344994459949944599444599994994459944459999445999cc6ccccccccccccccccccccccccccccccccccccccccccccccc
444444434444344444444443444444449999954499999549999544449999954999954444995444cc6ccc333333cccccccccccccccccc333333cccccccccc3333
4444444444444444444444444444444494444c9494499c94999c999994499c94999c999994c4493c6333bbbbbb3333ccc33b33ccc333bbbbbb3333ccc333bbbb
4444444444444444444444444444444444444433ccc3333c33335555ccc3333c33335555cccc33336bbb3333bbbb33333bbbb3333bbb3333bbbb33333bbb3333
44444444444444444444444444444444444444433333333333334444333333333333444433333333633333333333333333333333333333333333333333333333
44444444444444444444444444444444444444444111111111111111111111111111111111111111611111111111111111111111111111111111111111111111
444444444444444444444444444444444444444444cccc11ccc11111cc111ccc11111111ccc111116c111ccc11111111cc111ccc11111111ccc11111ccc11111
4444444444444444444444444444444444444444444c1111111ccccc11ccc11111cccc11111ccccc16ccc11111cccc1111ccc11111cccc11111ccccc111ccccc
44444444444444444444444444444444444444444444cc11111111111111111ccc111111111111111611111ccc1111111111111ccc1111111111111111111111
444444444444444444444444444444444444444444444cc111111111111111111111111111111111161111111111111111111111111111111111111111111111
4444444444444444444444444444444444444444444444111cccc11111cccc11111111111cccc11116cccc111111111111cccc11111111111cccc1111cccc111
444444444444444444444444444444444444444444444441c1111111111111111111ccccc1111111161111111111cccc111111111111ccccc1111111c1111111
44444444444444444444444444444444444444444444444111111111111111111111111111111111161111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444411111111111111111111111111cccc11161111111111111111111111111111111111111111111111
444444444444444444444444444444444444444444444444cc111cccccc11111cc111ccc111111ccc6c11111cc111ccccc111ccc11111111cc111ccc11111111
44444444444444444444444444444444444444444444444411ccc111111ccccc11ccc11111111111161ccccc11ccc11111ccc11111cccc1111ccc11111cccc11
4444444444444444444444444444444444444444444444441111111c111111111111111c11111111161111111111111c1111111ccc1111111111111ccc111111
44444444444444444444444444444444444444444444444411111111111111111111111111111cc1161111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444411cccc111cccc11111cccc11111ccc1188ccc11111cccc1111cccc111111111111cccc1111111111
44444444444444444444444444444444444444444444444411111111c111111111111111ccc11118888c111111111111111111111111cccc111111111111cccc
44444444444444444444444444444444444444444444444411111111111111111111111111111c177771c1111111111111111111111111111111111111111111
4444444444444444444444444444444444444444444444444111111111cccc111111111111cccc166661c111111111111111111111cccc111111111111111111
44444444444444444444444444444444444444444444444444cccc11111111cccc111ccc111111cc221c1111ccc11111cc111ccc111111ccccc11111cc111ccc
444444444444444444444444444444444444444444444444444c11111111111111ccc1111111111111cccc11111ccccc11ccc11111111111111ccccc11ccc111
4444444444444444444444444444444444444444444444444444cc11111111111111111c11111111cc111111111111111111111c11111111111111111111111c
44444444444444444444444444444444444444444444444444444cc111111cc11111111111111cc111111111111111111111111111111cc11111111111111111
44444444444444444444444444444444444444444444444444444411111ccc1111cccc11111ccc11111111111cccc11111cccc11111ccc111cccc11111cccc11
44444444444444444444444444444444444444444444444444444441ccc1111111111111ccc111111111ccccc111111111111111ccc11111c111111111111111
44444444444444444444444444444444444444444444444444444441111111111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111111111111111111111111111
444444444444444444444444444444444444444444444444444444441111111111111111f1fffff1111111111111111111111111111111111111111111111111
444444444444444444444444444444444444444444444444444444441111111111111111ff99991f111111111111111111111111111111111111111111111111
444444444444444444444444444444444444444444444444444444441111111111111111f9ffff9f111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111331111111111191999991111111111111111111111111111111111111111111111111
4444444444444444444444444444444444444444444444444444444411133b111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111355111111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444111311131111111111111111111111111111111111111111611111111111111111111111
44444444444444444444444444444444444444444444444444444444531331131111111111111111111111111111111111111111166616111111111111111111
44444444444444444444444444444444444444444444444444444444331133131111111111111111111111111111111111111111166666111111111111111111
44444444444444444444444444444444444444444444444444444444331113331111111111111111111111111111111111111111611111111111111111111111
44444444444444444444444444444444444444444444444444444444131113331111111111111111111111111111111111111161111111111111111111111111
44444444444444444444444444444444444444444444444444444444bbbbbbbb1111111111111111111111111111111111111116661611111111111111111111
44444444444444444444444444444444444444444444444444444444bb333b331111111111111111111111111111111111111116666611111111111111111111
44444444444444444444444444444444444444444444444444444444b34433331111111111111111111111111111111111111161111111111111111111111111
44444444444444444444444444444444444444444444444444444444344444341111111111111111111111111111111111111111111111111111111111111111
44444444444444444444444444444444444444444444444444444444444444441111111111111111111111111111111111111111111111111fffff1f11111111
4444444444444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111f19999ff11111111
4444444444444444444444444444444444444444444444444444444444444444111111111111111111111111111111111111111111111111ffffff9f11111111
44444444444444444444444444444444444444444444444444444444444444441111111111111111111111111111111111111111111111111999991911111111
44444444444444444444444444444444444444444444444444444444444444444111111111133111111111111111111111133111111111111111111111111111
44444444444444444444444444444444444444444444444444444444444444444411111111133b11111111111111111111133b11111111111111111111111111
44444444444444444444444444444444444444444444444444444444444444444441111111135511111111111111111111135511111111111111111111111111
44444444444444444444444444444444444444444444444444444444444444444444111111131113111111111111111111131113111111111113111311111111
44444444444444444444444444444444444444444444444444444444444444444444411153133113111111111111111153133113111111115313311311111111
44444444444444444444444444444444444444444444444444444444444444444444441133113313111111111111111133113313111111113311331311111111
44444444444444444444444444444444444444444444444444444444444444444444444133111333111111111111111133111333111111113311133311111111
44444444444444444444444444444444444444444444444444444444444444444444444413111333111111111111111113111333111111111311133311111111

__map__
2c2b2d2e3e2d2d2d2d2d2d2d2d2d2d2d3a3a3a3a3a3a3a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3c3b3634352d2d2d2d2d2d2d2d2d2d2d3a3a3a3a3a3a3a3a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040604050111021102033435363435343f3f3f3f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141423242526242526242524253f3f3f3f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141414242533332425333333333f3f3f3f3f00003f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14141414141423332526332526242624003f3f3f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414141414141415151515151515151500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414141414141421151515151515151500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414141414141405151515151515151500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414141414141414162115151515152100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000022050280502f0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001b5501d5501b5501b5501b540165301d5301d520005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
