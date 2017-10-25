#    Copyright (C) 2017 Nicolas Sauzede <nsauzede@laposte.net>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

from __future__ import print_function

gdb.execute("set confirm off")
gdb.execute("set pagination off")
gdb.execute("target remote 127.0.0.1:1234")
gdb.execute("set arch i8086")
#gdb.execute("disp/x *(unsigned char *)($eip+$cs*16)")
#gdb.execute("disp/i $eip+$cs*16")
#gdb.execute("disas *($eip+$cs*16)")
# here we simulate/ensure a genuine 8086 (at reset, cs=ffff ip=0000)
gdb.execute("set $cs=0xffff")
gdb.execute("set $eip=0x0000")
int_t = gdb.lookup_type("int")

def stepi(f):
	pc = gdb.parse_and_eval("$eip+$cs*16").cast(int_t)
#	f.write("PC=%x " % pc)
#	flags = gdb.parse_and_eval("$eflags")
#	f.write("flags=%s " % flags)
	f.write("cs=%04x " % gdb.parse_and_eval("$cs").cast(int_t))
	f.write("ip=%04x " % gdb.parse_and_eval("$eip").cast(int_t))
	f.write("ds=%04x " % gdb.parse_and_eval("$ds").cast(int_t))
	f.write("es=%04x " % gdb.parse_and_eval("$es").cast(int_t))
	f.write("ax=%04x " % gdb.parse_and_eval("$eax").cast(int_t))
	f.write("cx=%04x " % gdb.parse_and_eval("$ecx").cast(int_t))
	f.write("si=%04x " % gdb.parse_and_eval("$esi").cast(int_t))
	f.write("di=%04x " % gdb.parse_and_eval("$edi").cast(int_t))
	f.write("fl=%04x " % gdb.parse_and_eval("$eflags").cast(int_t))
	f.write("%-15s " % gdb.parse_and_eval("$eflags"))
	f.write("%02x" % gdb.parse_and_eval("*(unsigned char *)($eip+$cs*16)").cast(int_t))
	f.write("\n")
	gdb.execute("stepi")
	return pc

f=open("out.txt","wt")
pc = 0
#gdb.execute("disp")
#while pc < 0xffffb:
while pc < 0xffffa:
	pc = stepi(f)

gdb.execute("kill")
gdb.execute("quit")
