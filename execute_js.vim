
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" Author: Kenneth Belitzky <kenny@belitzky.com>

function! ExecuteJS()
python << EOF
import telnetlib
import re
from vim import current
tn = telnetlib.Telnet('localhost',4242,100)
tn.set_debuglevel(7)
repl = tn.expect(map (re.compile,["repl\d>"]))
repl_name = repl[2][-6:-1]
tn.write("%s.enter(content)" % repl_name)
selected = current.buffer.range(int(current.range.start),int(current.range.end))
tn.write(" ".join(selected))
tn.close()
EOF
endfunction
